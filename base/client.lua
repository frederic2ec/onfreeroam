local Dialog = ImportPackage("dialogui")
local _ = function(k,...) return ImportPackage("i18n").t(GetPackageName(),k,...) end

local freeroamMenu
local vehicleMenu
local vehicleSpawnMenu
local weaponMenu
local skinMenu
local hairsMenu
local shirtsMenu
local pantsMenu
local shoesMenu

local vehicleColor = {
    red = "FF0000",
    blue = "0000FF",
    green = "00FF00"
}

local hairsList = {
    hairs_police = "/Game/CharacterModels/SkeletalMesh/HZN_CH3D_Police_Hair_LPR",
    hairs_business = "/Game/CharacterModels/SkeletalMesh/HZN_CH3D_Hair_Business_LP",
    hairs_scientist ="/Game/CharacterModels/SkeletalMesh/HZN_CH3D_Hair_Scientist_LP",
    hairs_1 = "/Game/CharacterModels/SkeletalMesh/HZN_CH3D_Normal_Hair_01_LPR",
    hairs_3 = "/Game/CharacterModels/SkeletalMesh/HZN_CH3D_Normal_Hair_03_LPR",
    hairs_2 = "/Game/CharacterModels/SkeletalMesh/HZN_CH3D_Normal_Hair_02_LPR"
}


local shirtsList = {
    formal_shirt_1 = "/Game/CharacterModels/SkeletalMesh/Outfits/HZN_Outfit_Piece_FormalShirt_LPR",
    formal_shirt_2 ="/Game/CharacterModels/SkeletalMesh/Outfits/HZN_Outfit_Piece_FormalShirt2_LPR",
    simple_shirt = "/Game/CharacterModels/SkeletalMesh/Outfits/HZN_Outfit_Piece_Shirt_LPR",
    knitted_shirt_2 = "/Game/CharacterModels/SkeletalMesh/Outfits/HZN_Outfit_Piece_TShirt_Knitted2_LPR",
    knitted_shirt_1 = "/Game/CharacterModels/SkeletalMesh/Outfits/HZN_Outfit_Piece_TShirt_Knitted_LPR",
    tshirt = "/Game/CharacterModels/SkeletalMesh/Outfits/HZN_Outfit_Piece_TShirt_LPR",
}

local pantsList = {
    cargo_pants = "/Game/CharacterModels/SkeletalMesh/Outfits/HZN_Outfit_Piece_CargoPants_LPR",
    denim_pants = "/Game/CharacterModels/SkeletalMesh/Outfits/HZN_Outfit_Piece_DenimPants_LPR",
    formal_pants = "/Game/CharacterModels/SkeletalMesh/Outfits/HZN_Outfit_Piece_FormalPants_LPR"
}

local shoesList = {
    normal_shoes = "/Game/CharacterModels/SkeletalMesh/Outfits/HZN_Outfit_Piece_NormalShoes_LPR",
    business_shoes = "/Game/CharacterModels/SkeletalMesh/Outfits/HZN_Outfit_Piece_BusinessShoes_LPR"
}

AddEvent("OnTranslationReady", function()
    freeroamMenu = Dialog.create(_("freeroam_menu"), nil, _("vehicle"), _("weapon"), _("skin"), _("cancel"))

    -- Vehicle Menu
    vehicleMenu = Dialog.create(_("vehicle_menu"), nil, _("spawn_vehicle"), _("vehicle_customization"), _("cancel"))
    vehicleSpawnMenu = Dialog.create(_("vehicle_menu"), nil, _("spawn"), _("cancel"))
    Dialog.addSelect(vehicleSpawnMenu, 1, _("vehicle_list"), 8)
    vehicleCustomizeMenu = Dialog.create(_("vehicle_menu"), nil, _("set_plate"), _("set_color"), _("attach_nitro"), _("repair"), _("cancel"))
    Dialog.addSelect(vehicleCustomizeMenu, 1, _("vehicle_color"), 1)
    Dialog.addTextInput(vehicleCustomizeMenu, 1, _("plate_text"))

    -- Weapons Menu
    weaponMenu = Dialog.create(_("weapon_menu"), nil, _("give_weapon"), _("give_munition"), _("cancel"))
    Dialog.addSelect(weaponMenu, 1, _("weapon_list"), 8)
    Dialog.addSelect(weaponMenu, 1, _("slot"), 1, "1", "2", "3")

    -- Skin Menu
    skinMenu = Dialog.create(_("skin_menu"), nil, _("hairs"), _("shirts"), _("pants"), _("shoes"), _("cancel"))
    hairsMenu = Dialog.create(_("hairs_menu"), nil, _("set_hairs"), _("cancel"))
    Dialog.addSelect(hairsMenu, 1, _("hairs_list"), 8, table.unpack(hairsList))
    shirtsMenu = Dialog.create(_("shirts_menu"), nil, _("set_shirts"), _("cancel"))
    Dialog.addSelect(shirtsMenu, 1, _("shirts_list"), 8, table.unpack(shirtsList))
    pantsMenu = Dialog.create(_("pants_menu"), nil, _("set_pants"), _("cancel"))
    Dialog.addSelect(pantsMenu, 1, _("pants_list"), 8, table.unpack(pantsList))
    shoesMenu = Dialog.create(_("shoes_menu"), nil, _("set_shoes"), _("cancel"))
    Dialog.addSelect(shoesMenu, 1, _("shoes_list"), 8, table.unpack(shoesList))
end)

AddEvent("OnKeyPress", function( key )
    if key == "F4" then
        Dialog.show(freeroamMenu)
    end
end)

AddEvent("OnDialogSubmit", function(dialog, button, ...)
    local args = { ... }

	if dialog == freeroamMenu then
		if button == 1 then
			Dialog.show(vehicleMenu)
        end
        if button == 2 then
            CallRemoteEvent("CallWeaponMenu")
        end
        if button ==3 then
            Dialog.show(skinMenu)
        end
    end

    -- Vehicle Menu
    if dialog == vehicleMenu then
        if button == 1 then
            CallRemoteEvent("CallVehicleSpawnMenu")
        end
        if button == 2 then
            if GetPlayerVehicle() == 0 then
                AddPlayerChat(_("need_car"))
            else
                local formatedColorList = {}
                for k,v in pairs(vehicleColor) do
                    formatedColorList[v] = _(k)
                end
                Dialog.setSelectLabeledOptions(vehicleCustomizeMenu, 1, 1, formatedColorList)
                Dialog.show(vehicleCustomizeMenu)
            end
        end
    end

    if dialog == vehicleSpawnMenu then
        if button == 1 then
            if args[1] == "" then
                AddPlayerChat(_("select_vehicle"))
            else
                CallRemoteEvent("CallSpawnVehicle", args[1])
            end
        end
    end

    if dialog == vehicleCustomizeMenu then
        if button == 1 then
            if args[2] == "" then
                AddPlayerChat(_("enter_plate"))
            else
                if string.len(args[2]) > 13 then
                    AddPlayerChat(_("shorter_text"))
                else
                    CallRemoteEvent("CallSetVehiclePlate", args[2])
                end
            end
        end
        if button == 2 then
            if args[1] == "" then
                AddPlayerChat(_("select_color"))
            else
                CallRemoteEvent("CallSetVehicleColor", args[1])
            end
        end
        if button == 3 then
            CallRemoteEvent("CallAttachVehicleNitro")
        end
        if button == 4 then
            CallRemoteEvent("CallRepairVehicle")
        end
    end

    -- Weapon Menu
    if dialog == weaponMenu then
        if button == 1 then
            if args[1] == "" then
                AddPlayerChat(_("select_weapon"))
            else
                CallRemoteEvent("CallGiveWeapon", args[1], args[2])
            end
        end
        if button == 2 then
            CallRemoteEvent("CallGiveAmmo", args[2])
        end
    end

    -- Skin Menu
    if dialog == skinMenu then
        if button == 1 then
            local formatedHairsList = {}
            for k,v in pairs(hairsList) do
                formatedHairsList[v] = _("clothes_"..k)
            end
            Dialog.setSelectLabeledOptions(hairsMenu, 1, 1, formatedHairsList)
            Dialog.show(hairsMenu)
        end
        if button == 2 then
            local formatedShirtsList = {}
            for k,v in pairs(shirtsList) do
                formatedShirtsList[v] = _("clothes_"..k)
            end
            Dialog.setSelectLabeledOptions(shirtsMenu, 1, 1, formatedShirtsList)
            Dialog.show(shirtsMenu)
        end
        if button == 3 then
            local formatedPantsList = {}
            for k,v in pairs(pantsList) do
                formatedPantsList[v] = _("clothes_"..k)
            end
            Dialog.setSelectLabeledOptions(pantsMenu, 1, 1, formatedPantsList)
            Dialog.show(pantsMenu)
        end
        if button == 4 then
            local formatedShoesList = {}
            for k,v in pairs(shoesList) do
                formatedShoesList[v] = _("clothes_"..k)
            end
            Dialog.setSelectLabeledOptions(shoesMenu, 1, 1, formatedShoesList)
            Dialog.show(shoesMenu)
        end
    end
    if dialog == hairsMenu then
        if args[1] == "" then
            AddPlayerChat(_("select_hair"))
        else
            CallRemoteEvent("CallChangeSkin", 0, args[1])
        end
    end
    if dialog == shirtsMenu then
        if args[1] == "" then
            AddPlayerChat(_("select_shirt"))
        else
            CallRemoteEvent("CallChangeSkin", 1, args[1])
        end
    end
    if dialog == pantsMenu then
        if args[1] == "" then
            AddPlayerChat(_("select_pant"))
        else
            CallRemoteEvent("CallChangeSkin", 4, args[1])
        end
    end
    if dialog == shoesMenu then
        if args[1] == "" then
            AddPlayerChat(_("select_shoes"))
        else
            CallRemoteEvent("CallChangeSkin", 5, args[1])
        end
    end
end)

AddRemoteEvent("ShowVehicleSpawnMenu", function(vehicleList) 
    local formatedVehicleList = {}
    for k,v in pairs(vehicleList) do
        formatedVehicleList[k] = _(k)
    end
    Dialog.setSelectLabeledOptions(vehicleSpawnMenu, 1, 1, formatedVehicleList)
    Dialog.show(vehicleSpawnMenu)
end)

AddRemoteEvent("ShowWeaponMenu", function(weaponList)
    local formatedWeaponList = {}
    for k,v in pairs(weaponList) do
        formatedWeaponList[k] = _(k)
    end
    Dialog.setSelectLabeledOptions(weaponMenu, 1, 1, formatedWeaponList)
    Dialog.show(weaponMenu)
end)