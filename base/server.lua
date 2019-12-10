PlayerData = {}

AddEvent("OnPlayerJoin", function( player )
    CreatePlayerData(player)
end)

AddEvent("OnPlayerQuit", function( player )
    if PlayerData[player].vehicle ~= nil then
        DestroyVehicle(PlayerData[player].vehicle)      
    end
    DestroyPlayerData(player)
end)

function CreatePlayerData(player)
	PlayerData[player] = {}

    PlayerData[player].vehicle = nil
    PlayerData[player].hairs = nil
    PlayerData[player].shirts = nil
    PlayerData[player].pants = nil
    PlayerData[player].shoes = nil

    print("Data created for : "..player)
end

function DestroyPlayerData(player)
	if (PlayerData[player] == nil) then
		return
    end

    PlayerData[player] = nil

    print("Data destroyed for : "..player)
end