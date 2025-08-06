-- contains functions to visualise made maps for debugging. Not in Civ, in external program
local function check_in_table(tbl, val)
    for _, v in ipairs(tbl) do
        if v == val then
            return true
        end
    end
end

local doLog = false
function slthLog(text)
    if doLog then
        print(text)
    end
end

function changeLogLevel(boolean)
    doLog = boolean
end

print_counter = 0
function startPrinter()
    local index_string
    if print_counter > 29 then
        index_string = 'c' .. print_counter
    elseif print_counter > 19 then
        index_string = 'b' .. print_counter
    elseif print_counter > 9 then
        index_string = 'a' .. print_counter
    else
        index_string = print_counter
    end
    local print_count = print_counter
    print_counter = print_counter + 1
    return print_count
end



local OCEAN = 0
local LAND = 1
local HILLS = 2
local PEAK = 3
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
local text_hex_map = {["blue"] = '#0000FF',
        ["red"] = '#FF0000',
        ["yellow"] = '#FFFF00',
        ["green"] = '#00FF00',
        ["deepblue"] = '#3232AA',
        ["orange"] = '#FFAA00',
        ["black"] = '#000000',
        ["white"] = '#FFFFFF',
        ["cream"] = '#FFFDD0',
        ["pink"] = '#AAAA32',
        ["brown"] = '#777732',
        ["goldenrod"] = "#daa520",
        ["forestgreen"] = "#228b22",
        ["peach"] = "#f6a192",
        ["redscale1"] = "#807300",
        ["redscale2"] = "#9F6800",
        ["redscale3"] = "#BF5000",
        ["redscale4"] = "#DF2D00",
        ["redscale5"] = "#ff0000",
        ["redscale7"] = "#FF2249",
        ["redscale8"] = "#FF4488",
        ["redscale9"] = "#FF66BC",
}

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

-- Helper function to convert a HEX color string to RGB values (0-255).
local function hexToRGB(hex)
    hex = hex:gsub("#", "")
    return tonumber("0x" .. hex:sub(1, 2)), tonumber("0x" .. hex:sub(3, 4)), tonumber("0x" .. hex:sub(5, 6))
end

-- Helper function to convert HSL (Hue, Saturation, Lightness) to RGB.
-- h, s, l are in the range [0, 1]. r, g, b are in the range [0, 255].
local function HSLtoRGB(h, s, l)
    local r, g, b

    if s == 0 then
        r, g, b = l, l, l
    else
        local function hue2rgb(p, q, t)
            if t < 0 then t = t + 1 end
            if t > 1 then t = t - 1 end
            if t < 1/6 then return p + (q - p) * 6 * t end
            if t < 1/2 then return q end
            if t < 2/3 then return p + (q - p) * (2/3 - t) * 6 end
            return p
        end

        local q = l < 0.5 and l * (1 + s) or l + s - l * s
        local p = 2 * l - q
        r = hue2rgb(p, q, h + 1/3)
        g = hue2rgb(p, q, h)
        b = hue2rgb(p, q, h - 1/3)
    end

    return math.floor(r * 255 + 0.5), math.floor(g * 255 + 0.5), math.floor(b * 255 + 0.5)
end

-- Calculates the squared Euclidean distance between two RGB colors.
-- Using squared distance avoids a square root calculation and is sufficient for comparisons.
local function colorDistanceSq(r1, g1, b1, r2, g2, b2)
    local dr, dg, db = r1 - r2, g1 - g2, b1 - b2
    return dr * dr + dg * dg + db * db
end

local function generateDistinctColors(count, excludeList)
    if count > 60 then
        print('not generating distinct colours as crappy while loop and wayyy too many colours')
        return
    end
    local colors = {}
    local excludeRGB = {}
    local hueOffset = math.random() -- Start at a random point in the color wheel.
    local goldenRatio = 0.61803398875

    -- A minimum distance threshold to avoid colors that are too similar.
    -- (40*40 is a reasonable squared distance threshold for 8-bit RGB).
    local minDistanceSq = 1600

    -- Prepare the exclusion list by converting HEX to RGB
    for _, hex in ipairs(excludeList or {}) do
        local r, g, b = hexToRGB(hex)
        table.insert(excludeRGB, {r, g, b})
    end

    local generated = 0
    while generated < count do
        local h = (hueOffset + generated * goldenRatio) % 1.0

        -- Vary saturation and lightness in cycles to get a wider range of colors
        local cycle = math.floor(generated / 5) -- Change band every 5 colors
        local s = 0.5 + (cycle % 3) * 0.2 -- Varies saturation: 0.5, 0.7, 0.9
        local l = 0.6 - (math.floor(cycle / 3) % 2) * 0.2 -- Varies lightness: 0.6, 0.4

        local r, g, b = HSLtoRGB(h, s, l)
        local isTooClose = false

        -- Check against the exclusion list
        for _, rgb in ipairs(excludeRGB) do
            if colorDistanceSq(r, g, b, rgb[1], rgb[2], rgb[3]) < minDistanceSq then
                isTooClose = true
                break
            end
        end

        -- Also check against colors already generated to ensure they are distinct from each other
        if not isTooClose then
            for _, existingHex in ipairs(colors) do
                local er, eg, eb = hexToRGB(existingHex)
                if colorDistanceSq(r, g, b, er, eg, eb) < minDistanceSq then
                    isTooClose = true
                    break
                end
            end
        end

        if not isTooClose then
            colors[#colors + 1] = string.format('#%02X%02X%02X', r, g, b)
            generated = generated + 1
        else
            -- If a color is rejected, we still increment the hue generator
            -- to try a different part of the color space next time.
            generated = generated + 1
            count = count + 1 -- This ensures we still get the desired number of colors
        end
    end

    -- Trim the result in case we overshot
    while #colors > count do
        table.remove(colors)
    end

    return colors
end

local function getHexagonPoints(cx, cy, hexSize)     -- Function to generate hexagon points
    local points = {}
    for i = 0, 5 do
        local angle = math.pi / 3 * i + math.pi / 6  -- Rotate 30 degrees to point up
        local x = cx + hexSize * math.cos(angle)
        local y = cy + hexSize * math.sin(angle)
        table.insert(points, string.format("%.2f,%.2f", x, y))
    end
    return table.concat(points, " ")
end

function saveSVG(content, filename)
    local folder_extended = 'DebugDisplay/' .. filename
    local file = io.open(folder_extended, "w")
    if file then
        file:write(content)
        file:close()
        -- print('file written to', folder_extended)
        return true
    else
        return false, "Could not open file for writing"
    end
end

doLog = false
function slthLog(text)
    if doLog then
        print(text)
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

local function setUpSvgColors(height, width, grid, keymap, customSymbols)
    for i = 1, height do
        width = math.max(width, #grid[i])
    end

    -- set up keymap to actual colors
    local hexCodeMap = {}
    if keymap then
        for char, text in pairs(keymap) do
            hexCodeMap[char] = text_hex_map[text] or text
        end
    end

    local charCount = 0
    local uniqueChars = {}

    for y = 1, height do
        for x = 1, #grid[y] do
            local char = grid[y][x]
            if not char then print(' x/y didnt exist while looking for it for char', x, y) end
            if not uniqueChars[char] and not customSymbols[char] and not hexCodeMap[char] then
                charCount = charCount + 1
                uniqueChars[char] = true
            end
        end
    end
    -- print('unique char count', charCount)
    local colorPalette = generateDistinctColors(charCount, hexCodeMap) or {}
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
    local colors, colorIndex, colour_string = {}, 1, ""
    for char in pairs(uniqueChars) do
        colors[char] = colorPalette[colorIndex]
        colour_string = colour_string .. string.format('%s = %s |', char, colorPalette[colorIndex])
        colorIndex = (colorIndex % #colorPalette) + 1
    end

    return width, colors, hexCodeMap, charCount
end

local function labelRegions(svgParts, colourCount, colorAverageX, colorAverageY)
    for char, count in pairs(colourCount) do
        colorAverageX[char] = colorAverageX[char] / count
        colorAverageY[char] = colorAverageY[char] / count
        table.insert(svgParts, string.format(
        '  <text x="%.2f" y="%.2f" fill="#000000" font-size="100">%s</text>',
        colorAverageX[char], colorAverageY[char], char
        ))
    end
end

local function labelTiles(svgParts, height, grid, tilePositions, fontsize, xOffset, yOffset)
    local perTileXoffset
    local perTileYoffset
    for y = 1, height do
        for x = 1, #grid[y] do
            perTileXoffset = xOffset
            perTileYoffset = yOffset
            local iPlotID = (y-1) * g_iW + (x +1)
            if iPlotID > 999 then
                perTileXoffset = xOffset -fontsize - (fontsize / 2)
            elseif iPlotID > 99 then
                perTileXoffset = xOffset -fontsize
            elseif iPlotID > 9 then
                perTileXoffset = xOffset -fontsize +  (fontsize / 2)
            end
            table.insert(svgParts, string.format(
        '  <text x="%.2f" y="%.2f" fill="#000000" font-size="%d">%d</text>',
        tilePositions[y][x]['x']+perTileXoffset, tilePositions[y][x]['y']+perTileYoffset, fontsize, iPlotID
        ))
        end
    end
end
local function addColorKey(svgParts, svgHeight, colors)
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

local function copyTable(tbl, table_type)
    local new_tbl = {}
    if table_type == 'list' then
        for _, val in ipairs(tbl) do
            table.insert(new_tbl, val)
        end
    elseif table_type == 'dict' then
        for key, val in pairs(tbl) do
            new_tbl[key] = val
        end
    else
        print('ERROR: Tried to copy table without specifying the type of table')
    end
    return new_tbl
end

local function createHexGridSVG(grid, keymap, bDoLabeledRegions, bDoLabelledHexes, ignoreSymbolColors)
    local customSymbols
    if ignoreSymbolColors then
        customSymbols = {}
    else
        customSymbols = copyTable(symbols, 'dict')
    end
    local height = #grid
    local width, colors, hexCodeMap, charCount = setUpSvgColors(height, 0, grid, keymap, customSymbols)
    local hexSize = 30  -- Size of hexagon (radius)
    local hexHeight = hexSize * math.sqrt(3)
    local horizontalSpacing = 3 * hexSize / 2
    local verticalSpacing = hexHeight
    local padding = hexSize * 2
    -- Calculate SVG dimensions with padding
    local svgWidth = width * horizontalSpacing + padding * 2
    local svgHeight = height * verticalSpacing + padding * 2
    local svgParts = {
        '<?xml version="1.0" encoding="UTF-8"?>',
        string.format('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 %.2f %.2f">', svgWidth, svgHeight),
        '  <!-- Background -->',
        string.format('  <rect width="%.2f" height="%.2f" fill="#1a1a1a"/>', svgWidth, svgHeight)
    }
    local colorAverageX, colorAverageY, colourCount, hexPositions, usedColors = {}, {}, {}, {}, {}
    for y = 1, height do            -- Add hexagons
        hexPositions[y] = {}
        for x = 1, #grid[y] do
            local char = grid[y][x]
            if colors[char] or customSymbols[char] or hexCodeMap[char] then
                local colour = hexCodeMap[char] or customSymbols[char] or colors[char]
                if not usedColors[char] then usedColors[char] = colour end
                -- Calculate hex center position
                local cx = padding + x * horizontalSpacing + ((y-1) % 2) * (horizontalSpacing / 2)
                local cy = padding + y * verticalSpacing
                hexPositions[y][x] = {x=cx, y=cy}
                local hexPoints = getHexagonPoints(cx, cy, hexSize)      -- Create hexagon
                local hex = string.format(
                    '  <polygon points="%s" fill="%s" stroke="#000000" stroke-width="1"/>',
                    hexPoints,
                    colour)
                if not colorAverageX[char] then colorAverageX[char] = cx else colorAverageX[char] = colorAverageX[char] + cx end
                if not colorAverageY[char] then colorAverageY[char] = cy else colorAverageY[char] = colorAverageY[char] + cy end
                if not colourCount[char] then colourCount[char] = 1 else colourCount[char] = colourCount[char] + 1 end
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
    if bDoLabeledRegions then
        labelRegions(svgParts, colourCount, colorAverageX, colorAverageY)
    end
    if bDoLabelledHexes then
        labelTiles(svgParts, height, grid, hexPositions, 20, 0, 5)
    end
    if charCount < 40 then
        addColorKey(svgParts, svgHeight, usedColors)
    end
    table.insert(svgParts, '</svg>')
    return table.concat(svgParts, '\n')
end

local function createSquareGridSVG(grid, keymap, bDoLabeledRegions, bDoLabelled, ignoreSymbolColors)
    local customSymbols
    if ignoreSymbolColors then
        customSymbols = {}
    else
        customSymbols = copyTable(symbols, 'dict')
    end
    local height = #grid
    local width, colors, hexCodeMap, charCount = setUpSvgColors(height, 0, grid, keymap, customSymbols)
    local squareSize = 30  -- Size of hexagon (radius)
    local padding = squareSize * 2
    -- Calculate SVG dimensions with padding
    local svgWidth = width * squareSize + padding * 2
    local svgHeight = height * squareSize + padding * 2
    local svgParts = {
        '<?xml version="1.0" encoding="UTF-8"?>',
        string.format('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 %.2f %.2f">', svgWidth, svgHeight),
        '  <!-- Background -->',
        string.format('  <rect width="%.2f" height="%.2f" fill="#1a1a1a"/>', svgWidth, svgHeight)
    }
    local colorAverageX, colorAverageY, colourCount, squarePositions, usedColors = {}, {}, {}, {}, {}
    for y = 1, height do            -- Add hexagons
        squarePositions[y] = {}
        for x = 1, #grid[y] do
            local char = grid[y][x]
            if colors[char] or customSymbols[char] or hexCodeMap[char] then
                local colour = hexCodeMap[char] or customSymbols[char] or colors[char]
                if not usedColors[char] then usedColors[char] = colour end
                local cx = padding + x * squareSize
                local cy = padding + y * squareSize
                squarePositions[y][x] = {x=cx, y=cy}
                local hex = string.format(
                    '  <rect  x="%.2f" y="%.2f" width="%d" height="%d" fill="%s" stroke="#000000" stroke-width="1"/>',
                    cx, cy,squareSize, squareSize,colour)
                if not colorAverageX[char] then colorAverageX[char] = cx else colorAverageX[char] = colorAverageX[char] + cx end
                if not colorAverageY[char] then colorAverageY[char] = cy else colorAverageY[char] = colorAverageY[char] + cy end
                if not colourCount[char] then colourCount[char] = 1 else colourCount[char] = colourCount[char] + 1 end
                table.insert(svgParts, hex)
                if x == 1 or y == 1 then        -- Add coordinate guides for first row and column
                    local guide
                    if x == 1 then guide = y else guide = x end
                    table.insert(svgParts, string.format(
                        '  <text x="%.2f" y="%.2f" fill="#000000" font-size="%d" text-anchor="middle" dominant-baseline="middle">%s</text>',
                        cx, cy, squareSize/2, guide
                    ))
                end
            end
        end
    end
    if bDoLabeledRegions then
        labelRegions(svgParts, colourCount, colorAverageX, colorAverageY)
    end
    if bDoLabelled then
        labelTiles(svgParts, height, grid, squarePositions, 12, 20, 20)
    end
    if charCount < 40 then
        addColorKey(svgParts, svgHeight, usedColors)
    end
    table.insert(svgParts, '</svg>')
    return table.concat(svgParts, '\n')
end

local function make_2d(tbl)
    local table_of_table = {}
    if type(tbl[1]) == 'string' or type(tbl[1]) == 'number' then
        for y=0, g_iH do
            local transientXRow = {}
            local val = y * g_iW
            for x=0, g_iW do
                local idx = val + x
                local val_ = tbl[idx]
                table.insert(transientXRow, val_)
            end
            table.insert(table_of_table, transientXRow)
        end
    else
        table_of_table = tbl
    end
    return table_of_table
end

function simpleGridPrint(tbl, title, keymap, bDoLabeledRegions, bDoLabelledHexes, ignoreSymbolColors)
    local table_of_table = make_2d(tbl)
    local hexSvg = createHexGridSVG(table_of_table, keymap, bDoLabeledRegions, bDoLabelledHexes, ignoreSymbolColors)
    local adjusted_title = title .. '.svg'
    adjusted_title = startPrinter() .. '_' .. adjusted_title
    saveSVG(hexSvg, adjusted_title)
end

function simpleSquareGridPrint(tbl, title, keymap, bDoLabeledRegions, bDoLabelledHexes, ignoreSymbolColors)
    local table_of_table = make_2d(tbl)
    local Svg = createSquareGridSVG(table_of_table, keymap, bDoLabeledRegions, bDoLabelledHexes, ignoreSymbolColors)
    local adjusted_title = title .. '.svg'
    adjusted_title = startPrinter() .. '_' .. adjusted_title
    saveSVG(Svg, adjusted_title)
end
