local vehicleList = {
    vehicle_1 = 1,
    vehicle_2 = 2,
    vehicle_3 = 3,
    vehicle_4 = 4,
    vehicle_5 = 5,
    vehicle_6 = 6,
    vehicle_7 = 7,
    vehicle_8 = 8,
    vehicle_9 = 9,
    vehicle_10 = 10,
    vehicle_11 = 11,
    vehicle_12 = 12,
    vehicle_13 = 13,
    vehicle_14 = 14,
    vehicle_15 = 15,
    vehicle_16 = 16,
    vehicle_17 = 17,
    vehicle_18 = 18,
    vehicle_19 = 19,
    vehicle_20 = 20,
    vehicle_21 = 21,
    vehicle_22 = 22,
    vehicle_23 = 23,
    vehicle_24 = 24
}


AddRemoteEvent("CallVehicleSpawnMenu", function(player) 
    CallRemoteEvent(player, "ShowVehicleSpawnMenu", vehicleList)
end)

AddRemoteEvent("CallSpawnVehicle", function(player, model)
    local vehicleid = model:gsub("vehicle_", "")
    local x, y, z = GetPlayerLocation(player)
    local heading = GetPlayerHeading(player)
    
    if PlayerData[player].vehicle ~= nil then
        DestroyVehicle(PlayerData[player].vehicle)  
    end

    local vehicle = CreateVehicle(vehicleid, x, y, z, heading)

    PlayerData[player].vehicle = vehicle
    SetPlayerInVehicle(player, vehicle)
end)

AddRemoteEvent("CallSetVehicleColor", function(player, color)
    local vehicle = GetPlayerVehicle(player)
    
    SetVehicleColor(vehicle, "0x"..color)
end)

AddRemoteEvent("CallSetVehiclePlate", function(player, text)
    local vehicle = GetPlayerVehicle(player)

    SetVehicleLicensePlate(vehicle, text)
end)

AddRemoteEvent("CallAttachVehicleNitro", function(player)
    local vehicle = GetPlayerVehicle(player)

    AttachVehicleNitro(vehicle, true)
end)

AddRemoteEvent("CallRepairVehicle", function(player)
    local vehicle = GetPlayerVehicle(player)

    SetVehicleHealth(vehicle, 5000)
    for i=1,8 do
        SetVehicleDamage(vehicle, i, 0)
    end
end)