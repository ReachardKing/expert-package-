
$(document).ready(function () {
    $(() => {
        $(".Repair_HUD").hide();
        $("#Paycenter").hide();

        window.addEventListener("message", (event) => {
            var item = event.data;
            if (item != undefined && item.type === "HUD") {
                if (item.visible == true) {
                    $(".Repair_HUD").show();
                } else {
                    $(".Repair_HUD").hide();
                }
            }

            if (item.visible == false) {
                $(".Repair_HUD").hide();
            }

            if (item.type === "remove") {
                $(".Repair_HUD").hide();
            }

            $(document).on("click", ".Openthis", ()=> {
                $("#Paycenter").fadeIn();
                $(".Repair_HUD").fadeOut();
            })


            $(document).on("click", "#cash", ()=> {
                $("#Paycenter").fadeOut();
                $.post(`https://Repair/cash`, JSON.stringify({}))
            })

            $(document).on("click", "#bank", ()=> {
                $("#Paycenter").fadeOut();
                $.post(`https://Repair/bank`, JSON.stringify({}))
            })

            $(document).on("click", ".Repair", (event)=> {
                event.preventDefault();
            })

            $(document).on("click", ".Cancel", (event)=> {
                event.preventDefault();
            })

            $(document).on("click", ".Cancel", ()=> {
                $.post(`https://Repair/Cancel`, JSON.stringify({}))
            })

            $(document).on("click", ".Store", ()=> {
                $.post(`https://Repair/Store`, JSON.stringify({}))
            })

            $(document).on("click", ".local", ()=> {
                $.post(`https://Repair/local`, JSON.stringify({}))
            })
        })
    })

    $(() => {
        window.onload = () => {
            window.addEventListener("message", (event) => {
                const key = event.key;

                switch (key) {
                    case 38:
                        fetch(`https://${GetCurrentResourceName()}/up`, {
                            method: 'POST'
                        })
                    case 37:
                        fetch(`https://${GetCurrentResourceName()}/left`, {
                            method: 'POST'
                        })
                    case 39:
                        fetch(`https://${GetCurrentResourceName()}/right`, {
                            method: 'POST'
                        })
                    case 40:
                        fetch(`https://${GetCurrentResourceName()}/down`, {
                            method: 'POST'
                        })
                    case 13:
                        fetch(`https://${GetCurrentResourceName()}/enter`, {
                            method: 'POST'
                        })
                    case 27, 8:
                        fetch(`https://${GetCurrentResourceName()}/Esc`, {
                            method: 'POST'
                        })
                    case 8:
                        fetch(`https://${GetCurrentResourceName()}/Back`, {
                            method: 'POST'
                        })
                    break
                }
            })
        }
    })
})