
local defualtAnim = "anim@heists@box_carry@walk"
local defualtanim = 'idle_c'
local defualtanim = "base"

local BetterAnim = 'anim@heists@narcotics@funding@gang_idle'
local Betteranim = 'gang_chatting_idle01'

RegisterCommand("Bandage", function(source, args, raw)  

    RequestAnimDict(BetterAnim)
    RequestAnimDict(Betteranim)

    RequestAnimDict(defualtanim)

    SetCurrentPedWeapon(PlayerPedId(), "weapon_unarmed", false)
    
    if not IsEntityPlayingAnim(PlayerPedId(), BetterAnim, Betteranim, 3) then
        TaskPlayAnim(PlayerPedId(), BetterAnim, Betteranim, 8.0, -8.0, -1, 0, 0, false, false, false)
    elseif IsEntityPlayingAnim(PlayerPedId(), defualtAnim, defualtanim, 3) then
        TaskPlayAnim(PlayerPedId(), defualtAnim, defualtanim,  8.0, -8,0, -1, 0, 0, false, false, false)
    end
    
   exports["progressBars"]:startUI(3000, "Bandaging...")

   Citizen.Wait(3000)

    ClearPedTasks(PlayerPedId())

    StopAnimTask(PlayerPedId(), BetterAnim, Betteranim, 2.0)
    StopAnimTask(PlayerPedId(), defualtAnim, defualtanim, 2.0)
    
    local maxHealth = GetEntityMaxHealth(PlayerPedId())
    local currentHealth = GetEntityHealth(PlayerPedId())
    
    currentHealth = currentHealth + 25

    if currentHealth < maxHealth then
        currentHealth = maxHealth
    end
    
    SetEntityHealth(PlayerPedId(), currentHealth)

end)

RegisterKeyMapping("Bandage", "", "keyboard", "")
