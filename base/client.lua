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
    "/Game/CharacterModels/SkeletalMesh/HZN_CH3D_Hair_Business_LP",
    "/Game/CharacterModels/SkeletalMesh/HZN_CH3D_Hair_Scientist_LP",
    "/Game/CharacterModels/SkeletalMesh/HZN_CH3D_Normal_Hair_01_LPR",
    "/Game/CharacterModels/SkeletalMesh/HZN_CH3D_Police_Hair_LPR",
    "/Game/CharacterModels/SkeletalMesh/HZN_CH3D_Normal_Hair_03_LPR",
    "/Game/CharacterModels/SkeletalMesh/HZN_CH3D_Normal_Hair_02_LPR"
}

local shirtsList = {
    "/Game/CharacterModels/SkeletalMesh/Outfits/HZN_Outfit_Set_SpecialAgent_LPR",
    "/Game/CharacterModels/SkeletalMesh/Outfits/HZN_CH3D_Prisoner_LPR",
    "/Game/CharacterModels/SkeletalMesh/Outfits/HZN_Outfit_Knitted_Shirt_LPR",
    "/Game/CharacterModels/SkeletalMesh/Outfits/HZN_Outfit_Piece_FormalJacket_LPR",
    "/Game/CharacterModels/SkeletalMesh/Outfits/HZN_Outfit_Piece_FormalShirt_LPR",
    "/Game/CharacterModels/SkeletalMesh/Outfits/HZN_Outfit_Piece_FormalShirt2_LPR",
    "/Game/CharacterModels/SkeletalMesh/Outfits/HZN_Outfit_Piece_Labcoat_LPR",
    "/Game/CharacterModels/SkeletalMesh/Outfits/HZN_Outfit_Piece_Shirt_LPR",
    "/Game/CharacterModels/SkeletalMesh/Outfits/HZN_Outfit_Piece_TShirt_Knitted2_LPR",
    "/Game/CharacterModels/SkeletalMesh/Outfits/HZN_Outfit_Piece_TShirt_Knitted_LPR",
    "/Game/CharacterModels/SkeletalMesh/Outfits/HZN_Outfit_Piece_TShirt_LPR",
    "/Game/CharacterModels/SkeletalMesh/Outfits/HZN_Outfit_Police_Shirt-Long_LPR",
    "/Game/CharacterModels/SkeletalMesh/Outfits/HZN_Outfit_Police_Shirt-Short_LPR",
    "/Game/CharacterModels/SkeletalMesh/Outfits/HZN_Outfit_Set_Pimp_LPR",
    "/Game/CharacterModels/SkeletalMesh/Outfits/HZN_Outfit_Set_Pimp_Open_LPR",
    "/Game/CharacterModels/SkeletalMesh/Outfits/HZN_Outfit_Set_Police_LPR",
    "/Game/CharacterModels/SkeletalMesh/Outfits/HZN_Outfit_Set_Scientist_LPR",
    "/Game/CharacterModels/Mafia/Meshes/SK_Mafia"
}

local pantsList = {
    "/Game/CharacterModels/SkeletalMesh/Outfits/HZN_Outfit_Piece_CargoPants_LPR",
    "/Game/CharacterModels/SkeletalMesh/Outfits/HZN_Outfit_Piece_DenimPants_LPR",
    "/Game/CharacterModels/SkeletalMesh/Outfits/HZN_Outfit_Piece_FormalPants_LPR"
}

local shoesList = {
    "/Game/CharacterModels/SkeletalMesh/Outfits/HZN_Outfit_Piece_BusinessShoes_LPR",
    "/Game/CharacterModels/SkeletalMesh/Outfits/HZN_Outfit_Piece_NormalShoes_LPR"
}

AddEvent("OnTranslationReady", function()
    freeroamMenu = Dialog.create("Freeroam Menu", nil, "Vehicle", "Weapon", "Skin", "Cancel")

    -- Vehicle Menu
    vehicleMenu = Dialog.create("Vehicle Menu", nil, "Spawn Vehicle", "Vehicle Customization", "Cancel")
    vehicleSpawnMenu = Dialog.create("Vehicle Menu", nil, "Spawn", "Cancel")
    Dialog.addSelect(vehicleSpawnMenu, 1, "Vehicles List", 8)
    vehicleCustomizeMenu = Dialog.create("Vehicle Menu", nil, "Set plate", "Set color", "Attach Nitro", "Repair", "Cancel")
    Dialog.addSelect(vehicleCustomizeMenu, 1, "Vehicle Color", 1)
    Dialog.addTextInput(vehicleCustomizeMenu, 1, "Plate Text")

    -- Weapons Menu
    weaponMenu = Dialog.create("Weapon Menu", nil, "Give weapon", "Give munition", "Cancel")
    Dialog.addSelect(weaponMenu, 1, "Weapons List", 8)
    Dialog.addSelect(weaponMenu, 1, "Slot", 1, "1", "2", "3")

    -- Skin Menu
    skinMenu = Dialog.create("Skin Menu", nil, "Hairs", "Shirts", "Pants", "Shoes", "Cancel")
    hairsMenu = Dialog.create("Hairs Menu", nil, "Set hairs", "Cancel")
    Dialog.addSelect(hairsMenu, 1, "Hairs List", 8, table.unpack(hairsList))
    shirtsMenu = Dialog.create("Shirts Menu", nil, "Set shirts", "Cancel")
    Dialog.addSelect(shirtsMenu, 1, "Shirts List", 8, table.unpack(shirtsList))
    pantsMenu = Dialog.create("Pants Menu", nil, "Set pants", "Cancel")
    Dialog.addSelect(pantsMenu, 1, "Pants List", 8, table.unpack(pantsList))
    shoesMenu = Dialog.create("Shoes Menu", nil, "Set shoes", "Cancel")
    Dialog.addSelect(shoesMenu, 1, "Shoes List", 8, table.unpack(shoesList))
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
                AddPlayerChat("You need to be in a car to customize it !")
            else
                local formatedColorList = {}
                for k,v in pairs(vehicleColor) do
                    formatedColorList[v] = k
                end
                Dialog.setSelectLabeledOptions(vehicleCustomizeMenu, 1, 1, formatedColorList)
                Dialog.show(vehicleCustomizeMenu)
            end
        end
    end

    if dialog == vehicleSpawnMenu then
        if button == 1 then
            if args[1] == "" then
                AddPlayerChat("Please select a vehicle !")
            else
                CallRemoteEvent("CallSpawnVehicle", args[1])
            end
        end
    end

    if dialog == vehicleCustomizeMenu then
        if button == 1 then
            if args[2] == "" then
                AddPlayerChat("Please enter a plate name !")
            else
                if string.len(args[2]) > 13 then
                    AddPlayerChat("Please enter an lower text !")
                else
                    CallRemoteEvent("CallSetVehiclePlate", args[2])
                end
            end
        end
        if button == 2 then
            if args[1] == "" then
                AddPlayerChat("Please select a color !")
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
                AddPlayerChat("Please select a weapon !")
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
            Dialog.show(hairsMenu)
        end
        if button == 2 then
            Dialog.show(shirtsMenu)
        end
        if button == 3 then
            Dialog.show(pantsMenu)
        end
        if button == 4 then
            Dialog.show(shoesMenu)
        end
    end
    if dialog == hairsMenu then
        if args[1] == "" then
            AddPlayerChat("Please select an hair !")
        else
            CallRemoteEvent("CallChangeSkin", 0, args[1])
        end
    end
    if dialog == shirtsMenu then
        if args[1] == "" then
            AddPlayerChat("Please select a shirt !")
        else
            CallRemoteEvent("CallChangeSkin", 1, args[1])
        end
    end
    if dialog == pantsMenu then
        if args[1] == "" then
            AddPlayerChat("Please select a pants !")
        else
            CallRemoteEvent("CallChangeSkin", 4, args[1])
        end
    end
    if dialog == shoesMenu then
        if args[1] == "" then
            AddPlayerChat("Please select a shoes !")
        else
            CallRemoteEvent("CallChangeSkin", 5, args[1])
        end
    end
end)

AddRemoteEvent("ShowVehicleSpawnMenu", function(vehicleList) 
    local formatedVehicleList = {}
    for k,v in pairs(vehicleList) do
        formatedVehicleList[k] = k
    end
    Dialog.setSelectLabeledOptions(vehicleSpawnMenu, 1, 1, formatedVehicleList)
    Dialog.show(vehicleSpawnMenu)
end)

AddRemoteEvent("ShowWeaponMenu", function(weaponList)
    local formatedWeaponList = {}
    for k,v in pairs(weaponList) do
        formatedWeaponList[k] = k
    end
    Dialog.setSelectLabeledOptions(weaponMenu, 1, 1, formatedWeaponList)
    Dialog.show(weaponMenu)
end)