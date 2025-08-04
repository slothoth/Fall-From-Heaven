-- dummy functions so our script doesnt bug when we load it in game
-- since the actual functions do IO

-- actual function
local doLog = false
function slthLog(text)
    if doLog then
        slthLog(text)
    end
end

function createCharacterImageSVG(grid, rx_data, debug_mode, symbol_mapper, key_mapper)
    return {}
end

function saveSVG(content, filename)
    return
end

-- Actual functions, if we arent in the civ environment
if not Map then
    function createCharacterImageSVG(grid, rx_data, debug_mode, symbol_mapper, key_mapper)
        if not key_mapper then
            key_mapper = {}
        end
        local excludedPlots = {}
        local highlighted_regions = {}
        if rx_data then
            for k, v in pairs(rx_data) do
                for part in string.gmatch(k, "[^/]+") do
                    highlighted_regions[tonumber(part)] = tonumber(part)
                    break
                end
            end
            for key, val in pairs(rx_data) do
                for key_, val_ in pairs(val) do
                    local reason = val_['failure']
                    if reason == 'FULL_GATE' then
                        excludedPlots[val_['x'] .. '/' .. val_['y']] = true
                    end
                end
            end
        end
        local height = #grid
        local width = 0
        for i = 1, height do
            width = math.max(width, #grid[i])
        end

        -- First find unique characters
        local uniqueChars = {}
        local charCount = 0

        -- Predefined symbols remain the same
        local symbols = {
            ["O"] = '#0000FF', -- Blue
            ["P"] = '#FF0000', -- Red
            ["H"] = '#FFFF00', -- Yellow
            ["L"] = '#00FF00', -- Green
            ["TERRAIN_OCEAN"]  = '#0000FF',
            ["TERRAIN_COAST"]  = '#00FFFF',
            ["TERRAIN_GRASS"]  = '#00FF00',
            ["TERRAIN_PLAINS"]  = '#FFA500',
            ["TERRAIN_DESERT"]  = '#FFFF00',
            ["TERRAIN_TUNDRA"]  = '#800080',
            ["TERRAIN_SNOW"]  = '#FFFFFF',
            [OCEAN] = "#0000FF",
            [HILLS] = "#FFA500",
            [LAND] = "#00FF00",
            [-1] = '#0000FF'
        }
        if symbol_mapper then
            symbols = symbol_mapper
        end

        -- Get unique characters (removed the charCount < 9 limitation)
        for y = 1, height do
            for x = 1, #grid[y] do
                local char = grid[y][x]
                if not uniqueChars[char] then
                    charCount = charCount + 1
                    uniqueChars[char] = true
                end
                if debug_mode then
                    slthLog(x .. y)
                end
            end
        end

         -- Generate 256 distinct colors using HSV color space
        local function HSVtoRGB(h, s, v)
            local h_i = math.floor(h * 6)
            local f = h * 6 - h_i
            local p = v * (1 - s)
            local q = v * (1 - f * s)
            local t = v * (1 - (1 - f) * s)

            local r, g, b = 0, 0, 0
            if h_i == 0 then r, g, b = v, t, p
            elseif h_i == 1 then r, g, b = q, v, p
            elseif h_i == 2 then r, g, b = p, v, t
            elseif h_i == 3 then r, g, b = p, q, v
            elseif h_i == 4 then r, g, b = t, p, v
            elseif h_i == 5 then r, g, b = v, p, q
            end
            return math.floor(r * 255), math.floor(g * 255), math.floor(b * 255)
        end

        -- Function to generate optimized colors for small character sets
        local function colorDistance(r1, g1, b1, r2, g2, b2)
            local dr, dg, db = r1 - r2, g1 - g2, b1 - b2
            return math.sqrt(dr * dr + dg * dg + db * db)
        end

        local function hexToRGB(hex)
            return tonumber(hex:sub(2, 3), 16),
                   tonumber(hex:sub(4, 5), 16),
                   tonumber(hex:sub(6, 7), 16)
        end

        local function generateOptimizedColors(count, excludeList)
            local colors = {}
            local excludeRGB = {}

            for _, hex in ipairs(excludeList or {}) do
                local r, g, b = hexToRGB(hex)
                table.insert(excludeRGB, {r, g, b})
            end

            if count <= 64 then
                local hueStep = 1.0 / (count * 2)  -- oversample to account for skipped colors
                local i, generated = 1, 0
                while generated < count and i <= count * 4 do
                    local s = i % 2 == 0 and 1.0 or 0.8
                    local v = i % 2 == 0 and 0.9 or 1.0
                    local h = (i - 1) * hueStep
                    local r, g, b = HSVtoRGB(h, s, v)
                    local isTooClose = false
                    for _, rgb in ipairs(excludeRGB) do
                        if colorDistance(r, g, b, rgb[1], rgb[2], rgb[3]) < 10 then
                            isTooClose = true
                            break
                        end
                    end
                    if not isTooClose then
                        colors[#colors + 1] = string.format('#%02X%02X%02X', r, g, b)
                        generated = generated + 1
                    end
                    i = i + 1
                end
                return colors
            end
        end

        -- Generate color palette based on character count
        local colorPalette = generateOptimizedColors(charCount, {'#0000FF'}) or {}
        if #colorPalette == 0 then
            for i = 0, 255 do
                local h = (i % 16) / 16
                local s = math.floor(i / 16) % 4 / 3
                local v = math.floor(i / 64) % 4 / 3
                local r, g, b = HSVtoRGB(h, 0.5 + s * 0.5, 0.5 + v * 0.5)
                colorPalette[i + 1] = string.format('#%02X%02X%02X', r, g, b)
            end
        end

        -- Assign colors to characters
        local colors = {}
        local colorIndex = 1
        local colour_string = ""
        for char in pairs(uniqueChars) do
            colors[char] = colorPalette[colorIndex]
            colour_string = colour_string .. string.format('%s = %s | ', char, colorPalette[colorIndex])
            colorIndex = (colorIndex % 256) + 1
        end
        if debug_mode then
            slthLog(colour_string)
        end

        -- Calculate pixel size (make SVG 600px wide)
        local svgWidth = 600
        local pixelWidth = math.floor(svgWidth / width)
        local svgHeight = pixelWidth * height

        -- Start SVG string
        if debug_mode then
            slthLog('width: ' .. width .. ' | svgWidth: ' .. svgWidth .. ' | svgHeight: ' .. svgHeight .. ' | pixelWidth: ' .. pixelWidth)
        end
        -- local doKey = charCount < 20
        local doKey = true
        local KeyOffset = 0
        if doKey then
            KeyOffset = 100
        end
        local rulerOffset = pixelWidth * 3
        local svgParts = {
            '<?xml version="1.0" encoding="UTF-8"?>',
            string.format('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 %d %d">', svgWidth + rulerOffset, svgHeight + KeyOffset + rulerOffset),
        }

        local keyParts = {}

        -- Add color key (only if there are less than 20 unique characters to keep it readable)
        if doKey then
            local varKeyHeight = svgHeight + rulerOffset + (pixelWidth * 4)
            table.insert(keyParts, '  <!-- Color Key -->')
            local xPosition = 10
            local keys = {}
            for char in pairs(colors) do
                table.insert(keys, char)
            end
            table.sort(keys)

            for _, char in ipairs(keys) do
                local colour = colors[char]
                local label = key_mapper[char] or char
                if symbols[char] then
                    colour = symbols[char]
                end
                slthLog(string.format('label %s for char: %s. Colour: %s', label, char, colour))
                local labelLength = string.len(label) * 7
                local keyString = string.format('  <text x="%d" y="%d" fill="#FFFFFF" font-size="%d">',
                xPosition, varKeyHeight, math.floor(pixelWidth)) .. label .. ":"
                table.insert(keyParts, keyString .. '</text>')
                local rect = string.format(
                        '  <rect x="%d" y="%d" width="%d" height="%d" fill="%s"/>',
                        xPosition+labelLength-5, varKeyHeight-5, pixelWidth, pixelWidth, colour
                    )
                table.insert(keyParts, rect)
                if xPosition > svgWidth - labelLength then
                    xPosition = 10
                    varKeyHeight = varKeyHeight + 20
                else
                    xPosition = xPosition + labelLength + 10
                end
            end
        end

        -- Process string line by line
        local regionsEncountered = {}
        table.insert(keyParts, '  <!-- first of labelling -->')
        for y = 1, height do
            for x = 1, #grid[y] do
                if true then
                    local char = grid[y][x]
                    if colors[char] or symbols[char] then
                        local colour
                        if symbols[char] then
                            colour = symbols[char]
                        else
                            colour = colors[char]
                        end
                        -- Create SVG rect element for this character
                        local rect = string.format(
                            '  <rect x="%d" y="%d" width="%d" height="%d" fill="%s"/>',
                                ((x-1) * pixelWidth)+pixelWidth, ((y-1) * pixelWidth)+pixelWidth, pixelWidth, pixelWidth, colour
                        )
                        table.insert(svgParts, rect)
                        if not regionsEncountered[char] then
                            regionsEncountered[char] = true
                            table.insert(keyParts, string.format('  <text x="%d" y="%d" fill="#FFFFFF" font-size="%d">%s</text>',
                                    ((x-1) * pixelWidth)+pixelWidth, (y * pixelWidth)+pixelWidth, math.floor(pixelWidth), char))
                        end
                    end
                end
            end
        end
        for i, j in pairs(regionsEncountered) do
            slthLog(i)
        end

        -- centralised region numbers

        local function get_split_centres(char, char_xs, char_ys, char_centres)
            char_xs[char] = {}
            char_ys[char] = {}
            for y = 1, height do
                for x = 1, #grid[y] do
                    local map_char = grid[y][x]
                    if map_char == char then
                        table.insert(char_xs[char], x)
                        table.insert(char_ys[char], y)
                    end
                end
            end

            if check_in_table(char_xs[char], 1) and check_in_table(char_xs[char], width) then
                slthLog('found wrapping region')
                -- this is a split region, so we want to plot both
                -- first find all plots that are closer to one side or the other
                -- so to find left plots, find all plots that are below width/2
                local left_plots_x = {}
                local left_plots_y = {}
                local right_plots_x = {}
                local right_plots_y = {}
                for i, x in ipairs(char_xs[char]) do
                     if x > width/2 then
                         table.insert(left_plots_x, x)
                         table.insert(left_plots_y, char_ys[char][i])
                     else
                         table.insert(right_plots_x, x)
                         table.insert(right_plots_y, char_ys[char][i])
                     end
                end
                local left_x_centre = calculateCentre(left_plots_x)
                local left_y_centre = calculateCentre(left_plots_y)
                local right_x_centre = calculateCentre(right_plots_x)
                local right_y_centre = calculateCentre(right_plots_y)
                char_centres[char] = {left_x=left_x_centre, left_y=left_y_centre, right_x=right_x_centre , right_y=right_y_centre}
            else
                local x_centre = calculateCentre(char_xs[char])
                local y_centre = calculateCentre(char_ys[char])
                char_centres[char] = {x=x_centre, y=y_centre}
            end
            return char_centres
        end
        if true then
            slthLog('')
        else
            local char_xs = {}
            local char_ys = {}
            local char_centres = {}
            for char, color in pairs(colors) do
                if char ~= -1 then
                    char_centres = get_split_centres(char, char_xs, char_ys, char_centres)
                end
            end
            for key, val in pairs(highlighted_regions) do
                char_centres = get_split_centres(key, char_xs, char_ys, char_centres)
            end
            -- mark char_centres issues from world wrap on regions? fixed now
            table.insert(keyParts, '  <!-- centroids -->')
            for char, char_centroid in pairs(char_centres) do
                local fillcol = ''
                if highlighted_regions[char] then
                    fillcol = '#000000'
                else
                    fillcol = '#FFFFFF'
                end
                if char_centroid['left_x'] then
                    local left_centre_x = char_centroid['left_x']
                    local left_centre_y = char_centroid['left_y']
                    local svg_string = string.format('  <text x="%d" y="%d" fill="%s" font-size="%d">%s</text>',
                            left_centre_x * pixelWidth, left_centre_y * pixelWidth, fillcol,  math.floor(pixelWidth)*2, char)
                    table.insert(keyParts, svg_string)

                    local right_centre_x = char_centroid['right_x']
                    local right_centre_y = char_centroid['right_y']
                    svg_string = string.format('  <text x="%d" y="%d" fill="%s" font-size="%d">%s</text>',
                            right_centre_x * pixelWidth, right_centre_y * pixelWidth, fillcol, math.floor(pixelWidth)*2, char)
                    table.insert(keyParts, svg_string)
                else
                    local centre_x = char_centroid['x']
                    local centre_y = char_centroid['y']
                    local svg_string = string.format('  <text x="%d" y="%d" fill="%s" font-size="%d">%s</text>',
                            (centre_x) * pixelWidth, centre_y * pixelWidth, fillcol, math.floor(pixelWidth)*2, char)
                    table.insert(keyParts, svg_string)
                end
            end
        end

        table.insert(keyParts, '  <!-- Ruler label -->')
        local count = 0
        for i=0, svgWidth, pixelWidth*5 do
            table.insert(keyParts, string.format('  <text x="%d" y="%d" fill="#FFFFFF" font-size="%d">%s</text>',
                    i+pixelWidth, svgHeight+ rulerOffset, math.floor(pixelWidth)*3, count))
            count = count + 5
        end

        count = 0
        for i=0, svgHeight, pixelWidth*5 do
            table.insert(keyParts, string.format('  <text x="%d" y="%d" fill="#FFFFFF" font-size="%d">%s</text>',
                    svgWidth, i+pixelWidth, math.floor(pixelWidth)*3, count))
            count = count + 5
        end

        -- hightlighted region colour specifics
        if rx_data then
            local used_plots = {}
            for key, val in pairs(rx_data) do
                for key_, val_ in pairs(val) do
                    slthLog(string.format('for region: %d and plot %s', key, key_))
                    local x = val_['x']
                    local y = val_['y']
                    local reason = val_['failure']
                    local colour = '#000000'
                    if not used_plots[x .. '/' .. y] then
                        used_plots[x .. '/' .. y] = true
                        if reason == 'FULL_GATE' then
                            colour = '#FFFFFF'                      -- yellow
                            slthLog(string.format('highlighted region plot %d/%d is White as full gate', x, y))
                             local rect = string.format(
                                '  <rect x="%d" y="%d" width="%d" height="%d" fill="%s"/>',
                                ((x-1) * pixelWidth)+pixelWidth, ((y-1) * pixelWidth)+pixelWidth, pixelWidth, pixelWidth, colour
                            )
                            table.insert(keyParts, rect)
                        end
                    else
                        slthLog('plot already used!')
                    end
                end
            end
        end

        -- Close SVG
        table.insert(keyParts, '</svg>')
        local full =  {table.concat(svgParts, '\n'),  table.concat(keyParts, '\n')}
        return table.concat(full, '\n')
    end

    function saveSVG(content, filename)
        local file = io.open(filename, "w")
        if file then
            file:write(content)
            file:close()
            return true
        else
            return false, "Could not open file for writing"
        end
    end

    doLog = false
    function slthLog(text)
        if doLog then
            slthLog(text)
        end
    end

    -- Helper function to get averaged terrain from neighboring cells
    function getAveragedTerrain(grid, x, y, default_val)
        local neighbors = {}
        local directions
        if y % 2 == 1 then          -- Hex grid neighbor directions (odd-r offset)
            directions = {
                {x=0, y=-1},  -- North
                {x=1, y=-1},  -- Northeast
                {x=1, y=0},   -- Southeast
                {x=0, y=1},   -- South
                {x=-1, y=0},  -- Southwest
                {x=-1, y=-1}  -- Northwest
            }
        else
            directions = {
                {x=0, y=-1},  -- North
                {x=1, y=0},   -- Northeast
                {x=1, y=1},   -- Southeast
                {x=0, y=1},   -- South
                {x=-1, y=1},  -- Southwest
                {x=-1, y=0}   -- Northwest
            }
        end
        for _, dir in ipairs(directions) do     -- Collect valid neighboring terrains
            local newX = x + dir.x
            local newY = y + dir.y
            if newX >= 1 and newX <= #grid[1] and
               newY >= 1 and newY <= #grid and
               grid[newY][newX] ~= nil then
                table.insert(neighbors, grid[newY][newX])
            end
        end
        if #neighbors > 0 then  -- Return most common terrain type among neighbors
            local terrainCount = {}
            local maxCount = 0
            local mostCommon = neighbors[1]
            for _, terrain in ipairs(neighbors) do
                terrainCount[terrain] = (terrainCount[terrain] or 0) + 1
                if terrainCount[terrain] > maxCount then
                    maxCount = terrainCount[terrain]
                    mostCommon = terrain
                end
            end
            return mostCommon
        else
            return "L"      -- Default to flatland if no neighbors found
        end
    end

    -- Function to create a new hex grid
    function createHexGrid(squareGrid, default_filler)
        local height = #squareGrid
        local width = #squareGrid[1]
        -- Create empty hex grid, Hex grid needs different dimensions due to the offset pattern
        local hexWidth = width-- Hex tiles overlap horizontally
        local hexHeight = height                     -- was 3/4 for svg compression afaik, math.ceil(height * 3/4)
        local hexGrid = {}
        for y = 1, hexHeight do
            hexGrid[y] = {}
            for x = 1, hexWidth do
                hexGrid[y][x] = nil
            end
        end
        -- Convert square coordinates to hex coordinates and transfer terrain
        for y = 1, height do
            for x = 1, width do
                -- Convert square coordinates to hex coordinates using offset coordinates (odd-r offset)
                local hexX = x  -- Compress x coordinates
                local hexY = math.ceil(y * 3/4)          -- was less:  math.ceil(y * 3/4)
                if x % 2 == 1 then
                    hexY = hexY + 0.5           -- Offset every other row
                end
                hexY = math.floor(hexY + 0.5)       -- Round to nearest hex cell
                if hexX >= 1 and hexX <= hexWidth and hexY >= 1 and hexY <= hexHeight then      -- Ensure coordinates are within bounds
                    -- Transfer terrain type
                    hexGrid[hexY][hexX] = squareGrid[y][x]
                end
            end
        end
        -- Fill in any gaps with averaged terrain from neighbors
        for y = 1, hexHeight do
            for x = 1, hexWidth do
                if hexGrid[y][x] == nil then
                    hexGrid[y][x] = getAveragedTerrain(hexGrid, x, y, default_filler)
                end
            end
        end
        table.remove(hexGrid, #hexGrid)             -- TODO bodge fix here... worth looking into if we are doing weird stuff to get hexes, and if theres a simpler method
        return hexGrid
    end

    function createHexGridSVG(grid, debug_mode)
        -- Calculate dimensions
        local height = #grid
        local width = 0
        for i = 1, height do
            width = math.max(width, #grid[i])
        end
        -- Predefined symbols remain the same
        local symbols = {
            ["O"] = '#0000FF', -- Blue
            ["P"] = '#FF0000', -- Red
            ["H"] = '#FFFF00', -- Yellow
            ["L"] = '#00FF00', -- Green
        }
        -- Find unique characters (removed char count limitation)
        local uniqueChars = {}
        local charCount = 0
        for y = 1, height do
            for x = 1, #grid[y] do
                local char = grid[y][x]
                if not uniqueChars[char] and not symbols[char] then
                    charCount = charCount + 1
                    uniqueChars[char] = true
                end
            end
        end
        -- Color generation functions
        local function HSVtoRGB(h, s, v)
            local h_i = math.floor(h * 6)
            local f = h * 6 - h_i
            local p = v * (1 - s)
            local q = v * (1 - f * s)
            local t = v * (1 - (1 - f) * s)

            local r, g, b = 0, 0, 0
            if h_i == 0 then r, g, b = v, t, p
            elseif h_i == 1 then r, g, b = q, v, p
            elseif h_i == 2 then r, g, b = p, v, t
            elseif h_i == 3 then r, g, b = p, q, v
            elseif h_i == 4 then r, g, b = t, p, v
            elseif h_i == 5 then r, g, b = v, p, q
            end

            return math.floor(r * 255), math.floor(g * 255), math.floor(b * 255)
        end
        -- Function to generate optimized colors for small character sets
        local function generateOptimizedColors(count)
            local colors = {}
            if count <= 64 then
                -- For counts under 64, use distinct hues with optimized saturation and value
                local hueStep = 1.0 / count
                for i = 1, count do
                    -- Alternate between high and medium saturation/value for better distinction
                    local s = i % 2 == 0 and 1.0 or 0.8
                    local v = i % 2 == 0 and 0.9 or 1.0
                    local h = (i - 1) * hueStep
                    local r, g, b = HSVtoRGB(h, s, v)
                    colors[i] = string.format('#%02X%02X%02X', r, g, b)
                end
                return colors
            else
                return nil
            end
        end
        -- Generate color palette based on character count
        local colorPalette = generateOptimizedColors(charCount) or {}
        -- If optimized colors weren't generated, create 256-color palette
        if #colorPalette == 0 then
            for i = 0, 255 do
                local h = (i % 16) / 16
                local s = math.floor(i / 16) % 4 / 3
                local v = math.floor(i / 64) % 4 / 3
                local r, g, b = HSVtoRGB(h, 0.5 + s * 0.5, 0.5 + v * 0.5)
                colorPalette[i + 1] = string.format('#%02X%02X%02X', r, g, b)
            end
        end
        -- Assign colors to characters
        local colors = {}
        local colorIndex = 1
        local colour_string = ""
        for char in pairs(uniqueChars) do
            colors[char] = colorPalette[colorIndex]
            colour_string = colour_string .. string.format('%s = %s |', char, colorPalette[colorIndex])
            colorIndex = (colorIndex % #colorPalette) + 1
        end
        if debug_mode then
            slthLog(colour_string)
        end
        local hexSize = 30  -- Size of hexagon (radius)
        local hexWidth = hexSize * 2
        local hexHeight = hexSize * math.sqrt(3)
        local horizontalSpacing = 3 * hexSize / 2
        local verticalSpacing = hexHeight
        local padding = hexSize * 2
        -- Calculate SVG dimensions with padding
        local svgWidth = width * horizontalSpacing + padding * 2
        local svgHeight = height * verticalSpacing + padding * 2
        local function getHexagonPoints(cx, cy)     -- Function to generate hexagon points
            local points = {}
            for i = 0, 5 do
                local angle = math.pi / 3 * i + math.pi / 6  -- Rotate 30 degrees to point up
                local x = cx + hexSize * math.cos(angle)
                local y = cy + hexSize * math.sin(angle)
                table.insert(points, string.format("%.2f,%.2f", x, y))
            end
            return table.concat(points, " ")
        end
        local svgParts = {
            '<?xml version="1.0" encoding="UTF-8"?>',
            string.format('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 %.2f %.2f">', svgWidth, svgHeight),
            '  <!-- Background -->',
            string.format('  <rect width="%.2f" height="%.2f" fill="#1a1a1a"/>', svgWidth, svgHeight)
        }
        for y = 1, height do            -- Add hexagons
            for x = 1, #grid[y] do
                local char = grid[y][x]
                if colors[char] or symbols[char] then
                    local colour = symbols[char] or colors[char]
                    -- Calculate hex center position
                    local cx = padding + x * horizontalSpacing + ((y-1) % 2) * (horizontalSpacing / 2)
                    local cy = padding + y * verticalSpacing
                    local hexPoints = getHexagonPoints(cx, cy)      -- Create hexagon
                    local hex = string.format(
                        '  <polygon points="%s" fill="%s" stroke="#000000" stroke-width="1"/>',
                        hexPoints,
                        colour
                    )
                    table.insert(svgParts, hex)
                    if x == 1 or y == 1 then        -- Add coordinate guides for first row and column
                        local guide
                        if x == 1 then guide = y else guide = x end
                        table.insert(svgParts, string.format(
                            '  <text x="%.2f" y="%.2f" fill="#000000" font-size="%d" text-anchor="middle" dominant-baseline="middle">%s</text>',
                            cx, cy, hexSize/2, guide
                        ))
                    end
                end
            end
        end
        -- Add color key (only if there are less than 20 unique characters)
        if charCount < 20 then
            local keyY = svgHeight - 20
            table.insert(svgParts, string.format(
                '  <text x="10" y="%.2f" fill="#FFFFFF" font-size="14">Key: </text>',
                keyY
            ))
            local keyX = 50
            for char, color in pairs(colors) do
                table.insert(svgParts, string.format(
                    '  <rect x="%.2f" y="%.2f" width="20" height="20" fill="%s"/>',
                    keyX, keyY - 15, color
                ))
                table.insert(svgParts, string.format(
                    '  <text x="%.2f" y="%.2f" fill="#FFFFFF" font-size="14">%s</text>',
                    keyX + 25, keyY, char
                ))
                keyX = keyX + 60
            end
        end
        table.insert(svgParts, '</svg>')
        return table.concat(svgParts, '\n')
    end

    function calculateCentre(tbl)
        local sum_total = 0
        for _, y in ipairs(tbl) do
            sum_total = sum_total + y
        end
        local centre = math.floor(sum_total / #tbl)
        return centre
    end
end