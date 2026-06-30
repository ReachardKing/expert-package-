
$(document).ready(function () {

	const elements = {
		Dispatchcontainer: $(".Dispatchcontainer"),
		CadCalls: $("#CadCalls"),
		Ranger: $("#Ranger"),
		ShotsFired: $("#ShotsFired"),
		Emergency: $("#emergency"),
		Close: $(".close"),
		Waypoint: $(".waypoint"),
		Settings: $(".fa-gear"),
		CadSettings: $("#cadSettings"),
		OpenCadCalls: $("#open-cad-calls"),
		ToggleMeute: $("#ToggleMeute"),
		ClearBlips: $("#clearBlips"),
		ToggleAlert: $("#toggleAlert"),
		Alertdiable: $("#alertdiable"),
		ToggleMeute: $("#ToggleMeute"),
		ClearBlips: $("#clearBlips"),
		ToggleAlert: $("#toggleAlert"),
	}

	function SetElements(ele, state) {
		state ? ele.fadeIn() : ele.fadeOut()
	}

	SetElements(elements.Dispatchcontainer, false)
	SetElements(elements.CadSettings, false)
	SetElements(elements.OpenCadCalls, false)

	
	window.addEventListener("message", (event) => {
		const item = event.data;

		switch (item.type || item.action) {
			case "Dispatch":
				if (item.status) {
					SetElements(elements.Dispatchcontainer, true)
				} else {
					SetElements(elements.Dispatchcontainer, false)
				}
				break
			case "closeUI":
				SetElements(elements.CadSettings, false)
				SetElements(elements.OpenCadCalls, false)
				break

			default:
				break;
		}
	})

	window.addEventListener("message", (e) => {
		e.preventDefault()
		
		const SendNUIEvent = (name, data, callback) => {
			$.post(`https://DispatchSystem/${name}`, JSON.stringify(data), callback)
		}

		$(document).on('click', elements.CadCalls, () => {
			SendNUIEvent("CadCalls")
		})

		$(document).on('click', elements.Ranger, () => {
			SendNUIEvent("Ranger")
		})

		$(document).on('click', elements.ShotsFired, () => {
			SendNUIEvent("ShotsFired")
		})

		$(document).on('click', elements.Emergency, () => {
			SendNUIEvent("Nineoneone")
		})

		$(document).on('click', elements.Emergency, () => {
			SendNUIEvent("Threeone")
		})

		$(document).on('click', elements.Emergency, () => {
			SendNUIEvent("twoone")
		})

		$(document).on('click', elements.Close, () => {
			SendNUIEvent("close")
		})

		$(document).on('click', elements.Waypoint, () => {
			SendNUIEvent("waypoint")
		})

		$(document).on('click', elements.Settings, () => {
			$("#cadSettings").fadeIn();
		})

		$(document).on('click', elements.ToggleMeute, () => {
			SendNUIEvent("ToggleMeute");
		})
		$(document).on('click', elements.ClearBlips, () => {
			SendNUIEvent("clearBlips");
		})

		$(document).on('click', elements.ToggleAlert, () => {
			SendNUIEvent("toggleMutes")
		})

		$(document).on('click', elements.Alertdiable, () => {
			SendNUIEvent("toggles")
		})

		// Setting stuff
		$(document).on('click', elements.OpenCadCalls, () => {
			SetElements(elements.CadSettings, false)
		})
	})
	
	window.addEventListener("keyup", (e) => {
		if (e.key == 'Escape' || e.key == "Backspace" && $("#wrapper").is(':visible')) {
			SetElements(elements.Dispatchcontainer, false)
			SetElements(elements.CadSettings, false)
			SetElements(elements.OpenCadCalls, false)
			$.post(`https://DispatchSystem/close`, JSON.stringify({}));
		}
	})
})