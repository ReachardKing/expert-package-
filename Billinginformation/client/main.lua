
function UseBillingInfo()
    SendNUIMessage({
        action = "BillThis",
        visible = true
    })
    SetNuiFocus(true, true)
end

exports("UseBillingInfo", UseBillingInfo)