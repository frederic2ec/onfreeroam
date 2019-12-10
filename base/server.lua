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

AddCommand("getpos", function(player)
    local x, y, z = GetPlayerLocation(player)
    AddPlayerChat(player, "X : "..x.." Y : "..y.." Z : "..z)
end)

AddCommand("heli", function(player)
    local x, y, z = GetPlayerLocation(player)
    local vehicle = CreateVehicle(10, x, y, z)
    SetPlayerInVehicle(player, vehicle , 1 )
end)


AddCommand("wtf", function(player)
    local x, y, z = GetPlayerLocation(player)

    for i=1,4096 do
        local x2 = RandomFloat(x - 50000, x + 50000)
        local y2= RandomFloat(y - 50000, y + 50000)
        CreateVehicle(10, x2, y2, z + 500)
    end

    SetPlayerInVehicle(player, 1, 2)

    CreateTimer(function()
        for k,v in pairs(GetAllVehicles()) do 
            SetVehicleLinearVelocity(k, 300, 0, 200)
            local r = Random(100, 255)
            local g = Random(100, 255)
            local b = Random(100, 255)
            SetVehicleColor(k, RGB(r, g, b))
        end
    end,1000)
    
end)

AddCommand("spec", function(player, bool)
    SetPlayerSpectate( player, bool )
end)

AddCommand("time", function(player, player_time)
	if player_time == nil then
		return AddPlayerChat(player, "Use /time <0-24>")
	end

	player_time = tonumber(player_time)

	if player_time == nil or player_time < 0 or player_time > 24 then
		return AddPlayerChat(player, "Parameter \"time\" value should be between 0-24")
	end

	CallRemoteEvent(player, "ClientSetTime", player_time)
end)