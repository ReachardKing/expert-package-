
local chevrons = {
	"chevron-up-circle-sharp",
	"chevron-down-circle-sharp",
	"chevron-back-circle-sharp",
	"chevron-forward-circle-sharp",
	"chevron-redo-circle-sharp",
	"chevron-undo-circle-sharp",
	"chevron-addp-circle-sharp",
	"chevron-remove-circle-sharp"
}

-- Camera adjust amounts
local headingStep = 10.0   -- degrees left/right
local pitchStep = 5.0      -- degrees up/down
local zoomStep = 0.2       -- zoom for later if needed

-- Helper: clamp pitch to avoid flipping the camera
local function clamp(val, min, max)
	if val < min then return min end
	if val > max then return max end
	return val
end

-- Register callbacks dynamically
for _, chevron in ipairs(chevrons) do
	RegisterNUICallback(chevron, function(data, cb)
		local camHeading = GetGameplayCamRelativeHeading()
		local camPitch = GetGameplayCamRelativePitch()

		if chevron == "chevron-up-circle-sharp" then
			SetGameplayCamRelativePitch(clamp(camPitch - pitchStep, -70.0, 70.0), 1.0)
		
		elseif chevron == "chevron-down-circle-sharp" then
			SetGameplayCamRelativePitch(clamp(camPitch + pitchStep, -70.0, 70.0), 1.0)
		
		elseif chevron == "chevron-back-circle-sharp" then
			SetGameplayCamRelativeHeading(camHeading + headingStep)
		
		elseif chevron == "chevron-forward-circle-sharp" then
			SetGameplayCamRelativeHeading(camHeading - headingStep)
		
		elseif chevron == "chevron-undo-circle-sharp" then
			SetGameplayCamRelativeHeading(0.0) -- reset camera rotation
		
		elseif chevron == "chevron-redo-circle-sharp" then
			SetGameplayCamRelativeHeading(180.0) -- flip around
		
		elseif chevron == "chevron-addp-circle-sharp" then
			-- Could be zoom in
			SetCamFov(GetRenderingCam(), math.max(GetCamFov(GetRenderingCam()) - zoomStep, 30.0))
		
		elseif chevron == "chevron-remove-circle-sharp" then
			-- Could be zoom out
			SetCamFov(GetRenderingCam(), math.min(GetCamFov(GetRenderingCam()) + zoomStep, 90.0))
		end

		cb('ok')
	end)
end

RegisterNUICallback("close", function()
	SendNUIMessage({
		type = 'HUD', 
		visible = false
		
	})
	SetNuiFocus(false, false)
end)

RegisterNUICallback("close", function()
	SendNUIMessage({
		type = 'HUD', 
		visible = false,
		
	})
	SetNuiFocus(false, false)
end)

RegisterNUICallback("confirm", function()
	SendNUIMessage({
		type = 'HUD', 
		visible = false
		
	})
	SetNuiFocus(false, false)
end)

RegisterNUICallback("confirm", function()
	SendNUIMessage({
		type = 'HUD', 
		visible = false
		
	})
	SetNuiFocus(false, false)
end)

