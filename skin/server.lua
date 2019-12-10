AddRemoteEvent("CallChangeSkin", function(player, part, piece) 
    if part == 0 then
        PlayerData[player].hairs = piece
        CallRemoteEvent(player, "ChangeClothing", player, part, piece ) 
    end
    if part == 1 then
        PlayerData[player].shirts = piece
        CallRemoteEvent(player, "ChangeClothing", player, part, piece ) 
    end
    if part == 4 then
        PlayerData[player].pants = piece
        CallRemoteEvent(player, "ChangeClothing", player, part, piece ) 
    end
    if part == 5 then
        PlayerData[player].shoes = piece
        CallRemoteEvent(player, "ChangeClothing", player, part, piece ) 
    end
end)

AddRemoteEvent("CallStreamedClothes", function(player, otherplayer)
    if PlayerData[otherplayer].hairs ~= nil then
        CallRemoteEvent(player, "ChangeClothing", otherplayer, 0, PlayerData[otherplayer].hairs) 
    end
    if PlayerData[otherplayer].shirts ~= nil then
        CallRemoteEvent(player, "ChangeClothing", otherplayer, 1, PlayerData[otherplayer].shirts) 
    end
    if PlayerData[otherplayer].pants ~= nil then
        CallRemoteEvent(player, "ChangeClothing", otherplayer, 4, PlayerData[otherplayer].pants) 
    end
    if PlayerData[otherplayer].shoes ~= nil then
        CallRemoteEvent(player, "ChangeClothing", otherplayer, 5, PlayerData[otherplayer].shoes) 
    end
end)
