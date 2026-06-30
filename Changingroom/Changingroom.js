$(document).ready(() => {
    const menus = [".Changingroom-name-button", ".flex_align_justify"];

    function displayMenu(menu, show) {
        if (show) {
            menus.forEach(selector => $(selector).hide());
            $(menu).fadeIn();
        } else {
            $(menu).fadeOut();
        }
    }

    // Initially hide menus
    displayMenu(".Changingroom-name-button", false);
    displayMenu(".flex_align_justify", false);
	
	$( document ).keyup( function( event ) {
		if ( event.keyCode == 13 ) 
		{
			displayMenu(".Changingroom-name-button", false)
			displayMenu(".flex_align_justify", true)
		}
	} );
	
	$( document ).keyup( function( event ) {
		if ( event.keyCode == 27 ) 
		{
			displayMenu(".Changingroom-name-button", false)
			displayMenu(".flex_align_justify", false)
		}
	} );

    // Toggle main menu
    $(document).on("click", ".Changingroom-name-button", () => {
        displayMenu(".flex_align_justify", true);
        displayMenu(".Changingroom-name-button", false);
    });

    // Utility for POST requests (fire-and-forget, non-blocking)
    const sendPost = (endpoint, data) => {
        try {
            fetch(`https://Changingroom/${endpoint}`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(data || {}),
                keepalive: true
            }).catch(() => {});
        } catch (e) { }
    };

    // Button event bindings
    const buttonMappings = {
        "chevron-up-circle-sharp": "chevron-up-circle-sharp",
        "chevron-down-circle": "chevron-down-circle-sharp",
        "chevron-back-circle": "chevron-back-circle-sharp",
        "chevron-forward-circle": "chevron-forward-circle-sharp",
        "arrow-redo-circle-sharp": "chevron-redo-circle-sharp",
        "arrow-undo-circle-sharp": "chevron-undo-circle-sharp",
        "add-circle": "chevron-addp-circle-sharp",
        "remove-circle": "chevron-remove-circle-sharp"
    };

    Object.entries(buttonMappings).forEach(([selector, endpoint]) => {
        $(document).on("click", `ion-icon[name="${selector}"]`, () => sendPost(endpoint));
    });

    // Fixing typo "clcik" → "click"
    $(document).on("click", "#Setinfo", () => sendPost("setinfo"));

    // Fix: corrected selector typo: `.dec button, inc .button` → `.dec button, .inc button`
    $(document).on("click", ".dec button, .inc button", () => sendPost("updateinformation"));

    $(document).on("click", "#cancel", () => {
        displayMenu(".Changingroom-name-button", false);
        displayMenu(".flex_align_justify", false);
        sendPost("cancel");
    });

    $(document).on("click", ".close", () => {
        displayMenu(".flex_align_justify", false);
        sendPost("close");
    });

    $(document).on("click", ".setPreset, .update, .changeOutfit, .deleteOutfit", () => $(".updateprferences").fadeOut());
    $(document).on("click", "#Savedoutfits", () => $(".updateprferences").fadeIn());

    $(document).on("click", ".setPreset", () => sendPost("setPreset"));

    // Message listener
    window.addEventListener("message", (event) => {
        const item = event.data;

        if (item.type === "HUD") {
            if (item.visible) {
                $(".Changingroom-name-button").html(`<i class="fa-solid fa-shirt"></i> - Changing room`);
                displayMenu(".Changingroom-name-button", true);
            } else {
                displayMenu(".Changingroom-name-button", false);
            }
        }

        if (item.type === "remove") {
            displayMenu(".Changingroom-name-button", false);
            displayMenu(".flex_align_justify", false);
        }
    });

    // Confirm button
    $(document).on("click", "#Update", () => sendPost("confirm"));

    // Generic increment/decrement buttons handler (delegated). Avoid duplicate handlers.
    $(document).on("click", ".inc button, .dec button", function() {
        const value = $(this).attr("value");
        const category = $(this).closest("div").prev("label").text().trim();
        sendPost("buttonPress", { category, value });
    });

    // Key handling with simple rate limit to prevent flooding
    let lastKeyTime = 0;
    const KEY_THROTTLE_MS = 75;
    $(document).on("keyup", function(e) {
        const now = Date.now();
        if (now - lastKeyTime < KEY_THROTTLE_MS) return;
        lastKeyTime = now;

        if (e.key === 'Enter') {
            displayMenu(".Changingroom-name-button", false);
            displayMenu(".flex_align_justify", false);
            sendPost('confirm');
        }
        if (e.key === 'Escape') {
            displayMenu(".Changingroom-name-button", false);
            displayMenu(".flex_align_justify", false);
            sendPost('cancel');
        }
    });

});
