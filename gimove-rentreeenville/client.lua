local ESX = nil 

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

local isMenuOpen = false
local connect = false
local chargement = 0.0

local connectMenu = RageUI.CreateMenu("Bienvenue", "Gimove\'RP")
connectMenu.Closed = function()
    isMenuOpen = false
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	StartAnimConnect()
end)

function ConnectMenu()
    if not isMenuOpen then
        isMenuOpen = true
        RageUI.Visible(connectMenu, true)
        while isMenuOpen do
            RageUI.IsVisible(connectMenu, function()
                RageUI.Button("Appuyer sur ~b~[ENTRER]~s~ pour vous réveiller", nil, {}, not connect, {
                    onSelected = function()
                        connect = true
                    end
                })

                if connect then
                    RageUI.PercentagePanel(chargement, "Connection en cours... ~b~"..math.floor(chargement*100).."%", "", "", {})
        
                    if chargement < 1.0 then
                        chargement = chargement + 0.002
                    else 
                        chargement = 0
                    end

                    if chargement >= 1.0 then
                        DoScreenFadeOut(1500)
                        Wait(2000)
                        RenderScriptCams(false, false, 0, true, true)
                        Wait(1000)
                        FreezeEntityPosition(PlayerPedId(), false)
                        SetEntityVisible(PlayerPedId(), true, 0)
                        RageUI.CloseAll()
                        isMenuOpen = false
                        DoScreenFadeIn(2000)
                        TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_MOBILE", 0, 0)
                        Wait(4000)
                        ClearPedTasks(PlayerPedId())
                        ESX.ShowAdvancedNotification("Bienvenue", "~g~Information", "Bienvenue sur ~b~Gimove\'RP", 'CHAR_MP_FM_CONTACT', 1)
                        DisplayRadar(true)
                    end
                end
            end)
            Wait(1)
        end
    end
end

function StartAnimConnect()
    DoScreenFadeOut(1500)
    Wait(1500)
    FreezeEntityPosition(PlayerPedId(), true)
    SetEntityVisible(PlayerPedId(), false, 0)
    CameraConnect = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)
    SetCamCoord(CameraConnect, 606.99, 847.44, 357.91)
    SetCamRot(CameraConnect, 0.0, 0.0, 340.22)
    SetCamFov(CameraConnect, 45.97)
    ShakeCam(CameraConnect, "HAND_SHAKE", 0.2)
    SetCamActive(CameraConnect, true)
    RenderScriptCams(true, false, 2000, true, true)
    DisplayRadar(false)
    ConnectMenu()
end
