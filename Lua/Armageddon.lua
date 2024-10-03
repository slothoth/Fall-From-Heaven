-- [ ] Contributons to Armageddon count (Razing non-Veil cities (makes City Ruins improvement), Prophecy Mark units being created, Wonders being created. Ashen Veil founding, Ashen Veil spread, Compact broken (hyborem or Basium), Sheaim project, Illian projects? War equipment kills)
-- [ ] Lowering Armageddon count (Razing Veil Cities, Sanctifying city ruins, Hallowing of Elohim project, Prophecy Mark units dying, Wonders destroyed? )
-- [ ] Hijack Global Warming panel. We probably just steal the UI design of it.
-- [ ] Converting terrain to Hell terrain equivalent. Look into TerrainBuilder.SetTerrainType(), can also set Features and Resources. If not, can set plot Properties and visually change it, like JNR does? idk if that ever worked.
-- [ ] actions that happen once counter reaches certain value     Lua: Event : PlayerTurnStarted check if some property has reached a point. Actually where would I store state, there is no Game:SetProperty()

function AdjustArmageddonCount(iAmount)
    local iArmageddonCount = Game.GetProperty('ARMAGEDDON')
    if iArmageddonCount then
        Game.SetProperty('ARMAGEDDON', iArmageddonCount + iAmount)
    else
        print('Armageddon count not initilizaed!')
    end
end

-- Razing city Event, placing city ruins
local iCityCenter = GameInfo.Districts["DISTRICT_CITY_CENTER"].Index
local iCityRuins = GameInfo.Improvements['IMPROVEMENT_CITY_RUINS'].Index
local iReligionVeil = tostring(GameInfo.Religions["RELIGION_BUDDHISM"].Index)..'_HOLY_CITY'

function SG_Steppe_Raze(playerID, districtID, icityID, idistrictX, idistrictY, iDistrictType)
	if iDistrictType == iCityCenter then
		print ("City Center Removed")

		local iTurn = Game.GetCurrentGameTurn()

		local iAlreadyDeletedCheck = Game:GetProperty("SteppeCityRemoved" .. idistrictX .. "_" .. idistrictY)

		if iAlreadyDeletedCheck ~= iTurn then -- has not already been removed this turn
			Game:SetProperty("SteppeCityRemoved".. idistrictX.. "_".. idistrictY, iTurn)
			print ("city removed for the first time this turn!")
		else -- has already been removed this turn
			print ("city removed for the second(!) time this turn!")

			local pPlayerConfig = PlayerConfigurations[playerID]
            local bConquerChecker = true

            local tUnitsInTile = Units.GetUnitsInPlotLayerID(idistrictX, idistrictY, mapLayerAny)
            if tUnitsInTile then
                for k, pUnit in ipairs(tUnitsInTile) do
                    if pUnit:GetType() then
                        local pUnitOwner = pUnit:GetOwner()
                        if pUnitOwner then
                            --print (pUnitOwner)
                            if pUnitOwner ~= playerID then
                                bConquerChecker = false
                                print ("uh-oh! a foreign unit is in the city! Guess it wasn't razed then!")
                            else
                                print ("this city is owned by the civ that lost the city- good!")
                            end
                        end
                    end
                end
            end

            if bConquerChecker == true then
                print ("this city was (we think) razed by a steppe civ!")
                local player = Players[playerID];
                local pPlot = Map.GetPlot(idistrictX, idistrictY)
                ImprovementBuilder.SetImprovementType(pPlot, iCityRuins, 63)     -- barb
                local bIsVeilHoly = pPlot:GetProperty(iReligionVeil)
                if bIsVeilHoly and bIsVeilHoly > 0 then
                    AdjustArmageddonCount(-5)
                else
                    AdjustArmageddonCount(1)            -- can also do if majority religion veil, do -1
                end
            end
		end
	end
end

-- Santifying City Ruins improvements. not Event driven afaik. todo IN SPELLS

-- unit tracker, create increase armageddon, delete decrease
tArmageddonUnits = {}
tArmageddonAbilities = {}
function ArmageddonUnitSpawning(playerID, unitID)

end
-- building tracker, create increase armageddon, delete decrease
tArmageddonBuildings = {}
function ArmageddonBuildingMade(playerID, cityID, buildingID, plotID, isOriginalConstruction)

end
-- cover destroyed buildings in city raze logic

-- CityProjectCompleted for Elohim, Sheaim, Illian the Draw.
tProjectArmaCost = { [GameInfo.Projects['ELEGY_OF_THE_SHEAIM'].Index]   = 3,
                     [GameInfo.Projects['HALLOW_OF_ELOHIM'].Index]      = -3,
                     [GameInfo.Projects['THE_DRAW'].Index]              = 10}
function ArmaProjectComplete(playerID, cityID, projectID, buildingIndex, x, y, isCancelled)
    if isCancelled then return; end
    local iArmaCost = tProjectArmaCost[projectID]
    if iArmaCost then
        AdjustArmageddonCount(iArmaCost)
    end
end


-- war equipment ability on kill to increase count

-- done elsewhere? Hyborem or Basium entered. Veil holy city founded

function religionLostCity (playerID, cityID, eVisibility, influencingCityID)
    local pCity = CityManager.GetCity(playerID, cityID)
    local tCityReligions = pCity:GetReligion():GetReligionsInCity()
end

Events.CityReligionFollowersChanged.Add(religionLostCity)

Events.DistrictRemovedFromMap.Add(SG_Steppe_Raze)

Events.UnitAddedToMap.Add(ArmageddonUnitSpawning)

GameEvents.BuildingConstructed.Add(ArmageddonBuildingMade)

Events.CityProjectCompleted.Add(ArmaProjectComplete)
