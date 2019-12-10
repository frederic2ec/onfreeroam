local weaponList = {
    weapon_2 = 2,
    weapon_3 = 3,
    weapon_4 = 4,
    weapon_5 = 5,
    weapon_6 = 6,
    weapon_7 = 7,
    weapon_8 = 8,
    weapon_9 = 9,
    weapon_10 = 10,
    weapon_11 = 11,
    weapon_12 = 12,
    weapon_13 = 13,
    weapon_14 = 14,
    weapon_15 = 15,
    weapon_16 = 16,
    weapon_17 = 17,
    weapon_18 = 18,
    weapon_19 = 19,
    weapon_20 = 20,
}

AddRemoteEvent("CallWeaponMenu", function(player) 
    CallRemoteEvent(player, "ShowWeaponMenu", weaponList)
end)

AddRemoteEvent("CallGiveWeapon", function(player, weapon, slot)
    local weaponid = weapon:gsub("weapon_", "")

    SetPlayerWeapon(player, tonumber(weaponid), 1000, true, tonumber(slot), true)
end)

AddRemoteEvent("CallGiveAmmo", function(player, slot)
    local weapon, ammo = GetPlayerWeapon(tonumber(slot))

    SetPlayerWeapon(player, weapon, ammo + 1000, true, tonumber(slot), true)
end)