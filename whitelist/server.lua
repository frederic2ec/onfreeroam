local _ = function(k,...) return ImportPackage("i18n").t(GetPackageName(),k,...) end

whitelistStatus = true
whitelist = {
    "76561198048475587",
    "76561198044932670",
    "76561198036685625"
}

AddEvent("OnPlayerSteamAuth", function( player )
    local steamid = GetPlayerSteamId(player)
    if whitelistStatus then
        for k,v in pairs(whitelist) do
            if tostring(v) == tostring(steamid) then
                return
            end
        end
        KickPlayer(player, "You are not whitelisted")
    end
end)

AddCommand("whitelist", function(player, status) 
    local steamid = GetPlayerSteamId(player)

    for k,v in pairs(whitelist) do
        if tostring(v) == tostring(steamid) then
            if status == "true" then
                whitelistStatus = true
                AddPlayerChatAll("Whitelist on")
            else
                whitelistStatus = false
                AddPlayerChatAll("Whitelist off")
            end
        end
    end
end)

