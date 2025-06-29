

-- Global variables
mapSize = MapSize()

regMap = RegionMap.new()
riverMap = RiverMap.new()
plotMap = PlotMap.new()
terrainMap = TerrainMap.new()
spf = StartingPlotFinder.new()

mapSize.MapWidth = 84
mapSize.MapHeight = 52
regMap:createRegions()
regMap:PrintRegionMap()
regMap:PrintRegionList()
regMap:PrintRegionMap(true)
riverMap:createRiverMap()
river_plots = riverMap:PrintFlowMap()
plotMap:createPlotMap()
combined, out_plots = plotMap:PrintPlotMap()
rXPlots = regMap:PrintRegionRxMap()
region_plots = regMap:PrintRegionMap(true)

Slth_TerrainMap, rotatedGrid = terrainMap:createTerrainMap()

print('finished!')
----------------------------------------------------------
function createCharacterImageSVG(grid, debug_mode)
    local height = #grid
    if debug_mode then
        print('height is ' .. tostring(height))
    end
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
        ["TERRAIN_SNOW"]  = '#FFFFFF'
    }

    -- Get unique characters (removed the charCount < 9 limitation)
    for y = 1, height do
        for x = 1, #grid[y] do
            local char = grid[y][x]
            if not uniqueChars[char] and not symbols[char] then
                charCount = charCount + 1
                uniqueChars[char] = true
            end
            if debug_mode and cheese then
                print(x .. y)
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
            -- Fall back to 256-color generation for larger sets
            return nil
        end
    end



    -- Generate color palette based on character count
    local colorPalette = generateOptimizedColors(charCount) or {}
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
        print(colour_string)
    end

    -- Calculate pixel size (make SVG 600px wide)
    local svgWidth = 600
    local pixelWidth = math.floor(svgWidth / width)
    local svgHeight = pixelWidth * height

    -- Start SVG string
    if debug_mode then
        print('width: ' .. width .. ' | svgWidth: ' .. svgWidth .. ' | svgHeight: ' .. svgHeight .. ' | pixelWidth: ' .. pixelWidth)
    end

    local svgParts = {
        '<?xml version="1.0" encoding="UTF-8"?>',
        string.format('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 %d %d">', svgWidth, svgHeight),
        '  <!-- Background -->',
        string.format('  <rect width="%d" height="%d" fill="#000000"/>', svgWidth, svgHeight)
    }

    -- Add color key (only if there are less than 20 unique characters to keep it readable)
    if charCount < 20 then
        table.insert(svgParts, '  <!-- Color Key -->')
        table.insert(svgParts, string.format('  <text x="10" y="%d" fill="#FFFFFF" font-size="%d">',
            svgHeight - 10, math.floor(pixelWidth/2)))

        local keyString = "Key: "
        for char, color in pairs(colors) do
            keyString = keyString .. char .. "=" .. color .. " "
        end
        table.insert(svgParts, keyString .. '</text>')
    end

    -- Process string line by line
    for y = 1, height do
        for x = 1, #grid[y] do
            local char = grid[y][x]
            if colors[char] or symbols[char] then
                -- Create SVG rect element for this character
                local colour = symbols[char] or colors[char]
                local rect = string.format(
                    '  <rect x="%d" y="%d" width="%d" height="%d" fill="%s"/>',
                    (x-1) * pixelWidth, (y-1) * pixelWidth, pixelWidth, pixelWidth, colour
                )
                table.insert(svgParts, rect)
            end
        end
    end

    -- Close SVG
    table.insert(svgParts, '</svg>')

    return table.concat(svgParts, '\n')
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

function make_grid(tPlots, use_keys)
    -- iterate over combined string, to make the dict we want
    local squareGrid = {{}}
    local count = 1
    local row = 1
    local iter
    if use_keys then
        for idx, i in pairs(tPlots) do
            if count == mapSize.MapWidth then
                count = 0
                row = row + 1
                squareGrid[row] = {}
            else
                count = count + 1
                table.insert(squareGrid[row], i)
            end
        end
    else
        for idx, i in ipairs(tPlots) do
            if count == mapSize.MapWidth then
                count = 0
                row = row + 1
                squareGrid[row] = {}
            else
                count = count + 1
                table.insert(squareGrid[row], i)
            end
        end
    end

    return squareGrid
end

-------------------------------------------
-- Function to create a new hex grid
function createHexGrid(squareGrid)
    local height = #squareGrid
    local width = #squareGrid[1]

    -- Create empty hex grid
    -- Hex grid needs different dimensions due to the offset pattern
    local hexWidth = width-- Hex tiles overlap horizontally
    local hexHeight = math.ceil(height * 3/4)
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
            -- Convert square coordinates to hex coordinates
            -- Using offset coordinates (odd-r offset)
            local hexX = x  -- Compress x coordinates
            local hexY =  math.ceil(y * 3/4)

            -- Offset every other row
            if x % 2 == 1 then
                hexY = hexY + 0.5
            end

            -- Round to nearest hex cell
            hexY = math.floor(hexY + 0.5)

            -- Ensure coordinates are within bounds
            if hexX >= 1 and hexX <= hexWidth and hexY >= 1 and hexY <= hexHeight then
                -- Transfer terrain type
                hexGrid[hexY][hexX] = squareGrid[y][x]
            end
        end
    end

    -- Fill in any gaps with averaged terrain from neighbors
    for y = 1, hexHeight do
        for x = 1, hexWidth do
            if hexGrid[y][x] == nil then
                hexGrid[y][x] = getAveragedTerrain(hexGrid, x, y)
            end
        end
    end

    return hexGrid
end

-- Helper function to get averaged terrain from neighboring cells
function getAveragedTerrain(grid, x, y)
    local neighbors = {}
    local directions

    -- Hex grid neighbor directions (odd-r offset)
    if y % 2 == 1 then
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

    -- Collect valid neighboring terrains
    for _, dir in ipairs(directions) do
        local newX = x + dir.x
        local newY = y + dir.y

        if newX >= 1 and newX <= #grid[1] and
           newY >= 1 and newY <= #grid and
           grid[newY][newX] ~= nil then
            table.insert(neighbors, grid[newY][newX])
        end
    end

    -- Return most common terrain type among neighbors
    if #neighbors > 0 then
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
        -- Default to flatland if no neighbors found
        return "L"
    end
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
        print(colour_string)
    end

    -- Calculate hex dimensions for proper tiling
    local hexSize = 30  -- Size of hexagon (radius)
    local hexWidth = hexSize * 2
    local hexHeight = hexSize * math.sqrt(3)
    local horizontalSpacing = 3 * hexSize / 2
    local verticalSpacing = hexHeight

    -- Add padding for border
    local padding = hexSize * 2

    -- Calculate SVG dimensions with padding
    local svgWidth = width * horizontalSpacing + padding * 2
    local svgHeight = height * verticalSpacing + padding * 2

    -- Function to generate hexagon points
    local function getHexagonPoints(cx, cy)
        local points = {}
        for i = 0, 5 do
            local angle = math.pi / 3 * i + math.pi / 6  -- Rotate 30 degrees to point up
            local x = cx + hexSize * math.cos(angle)
            local y = cy + hexSize * math.sin(angle)
            table.insert(points, string.format("%.2f,%.2f", x, y))
        end
        return table.concat(points, " ")
    end

    -- Start SVG string
    local svgParts = {
        '<?xml version="1.0" encoding="UTF-8"?>',
        string.format('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 %.2f %.2f">', svgWidth, svgHeight),
        '  <!-- Background -->',
        string.format('  <rect width="%.2f" height="%.2f" fill="#1a1a1a"/>', svgWidth, svgHeight)
    }

    -- Add hexagons
    for y = 1, height do
        for x = 1, #grid[y] do
            local char = grid[y][x]
            if colors[char] or symbols[char] then
                local colour = symbols[char] or colors[char]
                -- Calculate hex center position
                local cx = padding + x * horizontalSpacing + ((y-1) % 2) * (horizontalSpacing / 2)
                local cy = padding + y * verticalSpacing

                -- Create hexagon
                local hexPoints = getHexagonPoints(cx, cy)
                local hex = string.format(
                    '  <polygon points="%s" fill="%s" stroke="#000000" stroke-width="1"/>',
                    hexPoints,
                    colour
                )
                table.insert(svgParts, hex)

                -- Add coordinate guides for first row and column
                if x == 1 or y == 1 then
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

    -- Close SVG
    table.insert(svgParts, '</svg>')

    return table.concat(svgParts, '\n')
end

svgListSquare = {}
svgList = {}
print('--- Plots --- ' .. #out_plots)
squareGrid = make_grid(out_plots)
local svgContent = createCharacterImageSVG(squareGrid)
table.insert(svgListSquare, svgContent)
saveSVG(svgContent, "output.svg")
print('--- Hex Version ---')
local hexGrid = createHexGrid(squareGrid)
local svgContent = createHexGridSVG(hexGrid)
table.insert(svgList, svgContent)
saveSVG(svgContent, "hexgrid.svg")



print('--- Region --- ' .. #region_plots)
squareGrid = make_grid(region_plots)
local svgContent = createCharacterImageSVG(squareGrid)
table.insert(svgListSquare, svgContent)
saveSVG(svgContent, "output_region.svg")
print('--- Hex Version ---')
local hexGrid = createHexGrid(squareGrid)
local svgContent = createHexGridSVG(hexGrid)
table.insert(svgList, svgContent)
saveSVG(svgContent, "hexgrid_region.svg")

print('--- River --- ' .. #river_plots)
squareGrid = make_grid(river_plots)
local svgContent = createCharacterImageSVG(squareGrid)
table.insert(svgListSquare, svgContent)
saveSVG(svgContent, "output_river.svg")
print('--- Hex Version ---')
local hexGrid = createHexGrid(squareGrid)
local svgContent = createHexGridSVG(hexGrid)
table.insert(svgList, svgContent)
saveSVG(svgContent, "hexgrid_river.svg")

print('--- Rx --- ' .. #rXPlots)
squareGrid = make_grid(rXPlots)
local svgContent = createCharacterImageSVG(squareGrid)
table.insert(svgListSquare, svgContent)
saveSVG(svgContent, "output_RX.svg")
print('--- Hex Version ---')
local hexGrid = createHexGrid(squareGrid)
local svgContent = createHexGridSVG(hexGrid)
table.insert(svgList, svgContent)
saveSVG(svgContent, "hexgrid_rx.svg")

print('--- Terrains --- ' .. #Slth_TerrainMap)
print(#Slth_TerrainMap)

squareGrid = make_grid(Slth_TerrainMap, true)

local svgContent = createCharacterImageSVG(squareGrid, true)
table.insert(svgListSquare, svgContent)
saveSVG(svgContent, "terrains.svg")
print('--- Hex Version ---')
local hexGrid = createHexGrid(squareGrid)
local svgContent = createHexGridSVG(hexGrid, true)
table.insert(svgList, svgContent)
saveSVG(svgContent, "hexgrid_terrains.svg")

print('--- Terrains Rotated--- ' .. #rotatedGrid)
squareGrid = make_grid(rotatedGrid, true)

local svgContent = createCharacterImageSVG(squareGrid, true)
table.insert(svgListSquare, svgContent)
saveSVG(svgContent, "terrains_rotated.svg")
print('--- Hex Version ---')
local hexGrid = createHexGrid(squareGrid)
local svgContent = createHexGridSVG(hexGrid, true)
table.insert(svgList, svgContent)
saveSVG(svgContent, "hexgrid_terrains_rotated.svg")

function combineSVGs(svgList, arrangement, targetWidth)
    -- arrangement is a table with:
    -- columns: number of columns to arrange SVGs in
    -- spacing: spacing between SVGs
    local columns = arrangement.columns or 1
    local spacing = arrangement.spacing or 50

    -- First pass: parse viewBox from each SVG to get dimensions
    local dimensions = {}
    local maxWidth = 0
    local maxHeight = 0

    for i, svg in ipairs(svgList) do
        -- Extract viewBox values using pattern matching
        local _, _, vx, vy, vw, vh = svg:find('viewBox="([%d%.]+) ([%d%.]+) ([%d%.]+) ([%d%.]+)"')
        dimensions[i] = {
            width = tonumber(vw),
            height = tonumber(vh)
        }
        maxWidth = math.max(maxWidth, dimensions[i].width)
        maxHeight = math.max(maxHeight, dimensions[i].height)
    end

    -- Calculate grid layout
    local rows = math.ceil(#svgList / columns)
    local baseWidth = (maxWidth * columns) + (spacing * (columns - 1))
    local baseHeight = (maxHeight * rows) + (spacing * (rows - 1))

    -- Calculate scale if targetWidth is provided
    local scale = 1
    if targetWidth then
        scale = targetWidth / baseWidth
    end

    -- Apply scale to dimensions
    local totalWidth = baseWidth * scale
    local totalHeight = baseHeight * scale
    local scaledSpacing = spacing * scale
    local scaledMaxWidth = maxWidth * scale
    local scaledMaxHeight = maxHeight * scale

    -- Start combined SVG
    local svgParts = {
        '<?xml version="1.0" encoding="UTF-8"?>',
        string.format('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 %.2f %.2f">', totalWidth, totalHeight),
        '  <!-- Background -->',
        string.format('  <rect width="%.2f" height="%.2f" fill="#1a1a1a"/>', totalWidth, totalHeight)
    }

    -- Add each SVG as a group with translation and scale
    for i, svg in ipairs(svgList) do
        local row = math.floor((i-1) / columns)
        local col = (i-1) % columns
        local x = col * (scaledMaxWidth + scaledSpacing)
        local y = row * (scaledMaxHeight + scaledSpacing)

        -- Extract the content between <svg> and </svg>
        local content = svg:match("<svg[^>]+>(.-)</svg>")

        -- Create a group with translation and scale transform
        table.insert(svgParts, string.format('  <g transform="translate(%.2f, %.2f) scale(%.4f)">',
            x, y, scale))
        -- Add the SVG content (excluding the outer svg tags)
        table.insert(svgParts, "    " .. content)
        table.insert(svgParts, "  </g>")
    end

    -- Close SVG
    table.insert(svgParts, '</svg>')

    return table.concat(svgParts, '\n')
end

-- Combine them in a 2x3 grid with 50px spacing
local arrangement = {
    columns = 2,
    spacing = 50
}

local combinedSVG = combineSVGs(svgList, arrangement, 1920)
saveSVG(combinedSVG, "combined_hexgrids.svg")

local combinedSVG = combineSVGs(svgListSquare, arrangement, 1920)
saveSVG(combinedSVG, "combined_squaregrids.svg")

function createArrowGrid(width, height)
    local grid = {}

    -- Calculate arrow dimensions based on grid size
    local arrowHeadWidth = math.floor(width / 3)
    local shaftHeight = math.floor(height / 3)
    local shaftY = math.floor(height / 2 - shaftHeight / 2)

    for y = 0, height - 1 do
        for x = 0, width - 1 do
            local index = y * width + x + 1

            -- Default to empty space
            grid[index] = 0

            -- Draw arrow shaft
            if y >= shaftY and y < shaftY + shaftHeight and x < width - arrowHeadWidth then
                grid[index] = 1
            end

            -- Draw arrow head
            local distanceFromCenter = math.abs(y - math.floor(height / 2))
            local arrowHeadStart = width - arrowHeadWidth
            if x >= arrowHeadStart and
               distanceFromCenter <= (x - arrowHeadStart) and
               distanceFromCenter <= (width - x - 1) then
                grid[index] = 1
            end
        end
    end
    return grid
end

local grid = createArrowGrid(mapSize.MapWidth, mapSize.MapWidth)
local test_grid = make_grid(grid)
local svgContent = createCharacterImageSVG(test_grid, true)
saveSVG(svgContent, "test.svg")
print('--- Hex Version ---')
local hexGrid = createHexGrid(test_grid)
local svgContent = createHexGridSVG(hexGrid, true)
saveSVG(svgContent, "test_hex.svg")

local new_grid, newWidth, newHeight = rotateGrid(grid, mapSize.MapWidth, mapSize.MapWidth, 90)
local test_grid = make_grid(new_grid)
local svgContent = createCharacterImageSVG(test_grid, true)
saveSVG(svgContent, "test_r.svg")
print('--- Hex Version ---')
local hexGrid = createHexGrid(test_grid)
local svgContent = createHexGridSVG(hexGrid, true)
saveSVG(svgContent, "test_r_hex.svg")