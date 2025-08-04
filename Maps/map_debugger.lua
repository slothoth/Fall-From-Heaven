local missing_globals = {}

setmetatable(_G, {
    __index = function(t, k)
        if missing_globals[k] == nil then
            missing_globals[k] = true
            print("[MISSING GLOBAL]", k)
        end
        return nil
    end
})

local tExternals = {['PythonConversion']=true, ['IO_Fake']=true}
local tReplace = {['IO_Fake']='IO_Debug'}
if not include then
    function include(name)
      local newName = name
      if tExternals[name] then
        newName = tReplace[name] or name
        print('loading', newName)
        local ok, err = pcall(require, newName)
        if not ok then
          print('was not ok, err', err)
          dofile(newName .. ".lua")
        end
      end
    end
end

-- globals
g_PLOT_TYPE_MOUNTAIN = 0
g_PLOT_TYPE_HILLS = 1
g_PLOT_TYPE_LAND = 2
g_PLOT_TYPE_OCEAN = 3

g_TERRAIN_TYPE_GRASS = 0
g_TERRAIN_TYPE_GRASS_HILLS = 1
g_TERRAIN_TYPE_GRASS_MOUNTAIN = 2
g_TERRAIN_TYPE_PLAINS = 3
g_TERRAIN_TYPE_PLAINS_HILLS = 4
g_TERRAIN_TYPE_PLAINS_MOUNTAIN = 5
g_TERRAIN_TYPE_DESERT = 6
g_TERRAIN_TYPE_DESERT_HILLS = 7
g_TERRAIN_TYPE_DESERT_MOUNTAIN = 8
g_TERRAIN_TYPE_TUNDRA = 9
g_TERRAIN_TYPE_TUNDRA_HILLS = 10
g_TERRAIN_TYPE_TUNDRA_MOUNTAIN = 11
g_TERRAIN_TYPE_SNOW = 12
g_TERRAIN_TYPE_SNOW_HILLS = 13
g_TERRAIN_TYPE_SNOW_MOUNTAIN = 14
g_TERRAIN_TYPE_COAST = 15
g_TERRAIN_TYPE_OCEAN = 16

-- classes
FeatureGenerator = {}
FeatureGenerator.__index = FeatureGenerator

Map = {}
Map.MapTable = {}
for i = 0, 84* 52 do
    Map.MapTable[i] = -1
end
function Map.GetGridSize()
    return 84, 52
end

function Map.GetPlotByIndex(iPlotIndex)
    return Map.MapTable[iPlotIndex]
end

MapConfiguration = {}
configs = {temperature=1, world_age=2, resources=2,start=2, rainfall=1, EXCLUDE_NATURAL_WONDERS={}}
function MapConfiguration.GetValue(text)
    if not configs[text] then
      raise('error:', text, 'not found in mapConfig dummy')
    end
    return configs[text]
end
GameConfiguration = {}
function GameConfiguration.GetValue(text)
    if not configs[text] then
      raise('error:', text, 'not found in GameConfiguration dummy')
    end
    return configs[text]
end

TerrainBuilder = {}
function TerrainBuilder.SetTerrainType(pPlot, iTerrainIndex)
    pPlot = iTerrainIndex
end
function TerrainBuilder.AnalyzeChokepoints()
    return
end
function TerrainBuilder.StampContinents()
    return
end


AreaBuilder = {}
function AreaBuilder.Recalculate(text)
    return
end



dofile("Erebus.lua")

print('doing map script')
GenerateMap()
print("\n--- Missing Globals Detected ---")
for k in pairs(missing_globals) do
    print(k)
end
