AddEvent("OnPlayerSpawn", function(player)
    local randomX = RandomFloat(183818, -217367)
    local randomY = RandomFloat(106969, -179489)
    SetPlayerLocation(player, randomX, randomY, 10000.000000)
    Delay(1000, function()
        AttachPlayerParachute(player, true)
    end)  
end)

