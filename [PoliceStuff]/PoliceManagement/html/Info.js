
// Police info

$(document).ready(() => {

    const appURL = "https://PoliceManagement";

    $(".container").hide();

    $(document).on("click", "#button-confirm", () => {

        const postDats = {
            Name: $("#Search-name").val(),
            callsign: $("#callsign").val(),
            position: $("#position").val(),
            ranks: $("#rank").val(),
            certs: $("#certs").val(),
            Trainer: $("#Trainer").val(),
        }

        $.post(`${appURL}/NewEmployees`, JSON.stringify({ postDats }));
        $.post(`${appURL}/UpdateCredentials`, JSON.stringify({ postDats }));
        $.post(`${appURL}/remove`, JSON.stringify({}));
    })

    $(document).on("click", "#Terminate", () => {
        const now = new Date();
        now.setDate(now.getDate() + 30);
        const postDats = {
            Name: $("#Search-name").val(),
            callsign: $("#callsign").val(),
            position: $("#position").val(),
            ranks: $("#rank").val(),
            certs: $("#certs").val(),
            Trainer: $("#Trainer").val(),
            current: now
        }

        $.post(`${appURL}/Terminate`, JSON.stringify({ postDats }));
        $.post(`${appURL}/remove`, JSON.stringify({}));
    })

    $(document).on("click", "#Suspension", () => {
        const now = new Date();
        const postDats = {
            Name: $("#Search-name").val(),
            callsign: $("#callsign").val(),
            position: $("#position").val(),
            ranks: $("#rank").val(),
            certs: $("#certs").val(),
            Trainer: $("#Trainer").val(),
            current: now
        }

        $.post(`${appURL}/Suspension`, JSON.stringify({ postDats }));
        $.post(`${appURL}/remove`, JSON.stringify({}));
    })

    $(document).on("click", "#PermanentlyTreminated", () => {
        const now = new Date();
        const postDats = {
            Name: $("#Search-name").val(),
            callsign: $("#callsign").val(),
            position: $("#position").val(),
            ranks: $("#rank").val(),
            certs: $("#certs").val(),
            Trainer: $("#Trainer").val(),
            current: now
        }

        $.post(`${appURL}/PermanentlyTerminated`, JSON.stringify({ postDats }));
        $.post(`${appURL}/remove`, JSON.stringify({}));
    })

    $(document).on("click", ".close, .button-cancel, .button-cancel", () => {
        $.post(`${appURL}/remove`, JSON.stringify({}));
        $.post(`${appURL}/remove`, JSON.stringify({}));
    })
});
