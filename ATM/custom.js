

// Post functions to lua
$(document).ready((() => {


    const elements = {
        ShowATM: $(".flex_align_justify"),
        HideATM: $(".flex_align_justify"),
        confirmbutton: $(".confirmtransactions"),
        confirmDecline: $(".confirmDecline"),
        close: $(".close")
    }

    setEleVisible(false, elements.ShowATM);

    function setEleVisible(state, el) {
        {
            state ? $(el).fadeIn() : $(el).fadeOut();
        }
    }

    function successScreenScreen(state) {
        {
            state ? $("#successScreen").fadeIn() : $("#successScreen").fadeOut();
        }
    }

    elements.confirmbutton.click(() => {
        setEleVisible(true, elements.ShowATM);
        $.post(`https://${GetcurrentResourceName()}/sound`, JSON.stringify({}))
    });

    elements.confirmbutton.click(() => {
        setTimeout(() => {
            successScreenScreen(true);
        }, 300);
        return false;
    });

    elements.confirmbutton.click(() => {
        $.post(`https://${GetcurrentResourceName()}/sound`, JSON.stringify({}));
        $.post(`https://${GetcurrentResourceName()}/useATM`, JSON.stringify({
            action: action,
            ammount: $("#Deposit").val(),
            transaction: $("#Withdraw").val(),
            transferamount: $("#Transfter").val(),
            Tragetid: $("#TragetID").val()
        }))
        $("#Deposit").val("");
        $("#Withdraw").val("");
        $("#Transfter").val("");
        $("#TragetID").val("");
        return false;
    });

    elements.close.click(() => {
        $.post(`https://${GetcurrentResourceName()}/sound`, JSON.stringify({}));
        $.post(`https://${GetcurrentResourceName()}/close`, JSON.stringify({}));
    });

window.addEventListener("message", (event) => {
    const item = event.data;
    if (!item || !item.type) return; // Prevent errors

    switch (item.type) {
        case "showATM":
            setEleVisible(true, elements.ShowATM);
            break;

        case "hideATM":
            setEleVisible(false, elements.ShowATM);
            setEleVisible(false, elements.HideATM);
            break;

        case "successScreen":
            successScreenScreen(item.state);
            break;

        default:
            break;
    }
});


    $("button[type=submit]").click(function () {
        action = $(this).text();
    })
    
    window.addEventListener("keyup", ( event ) => {
        if ( event.key === "escape") {
        setEleVisible(false, $(".ShowBankUI"));
        setEleVisible(false, $(".flex_align_justify"));
            $.post('https://ATM/closeUI', JSON.stringify({}));
        }
        

        if ((event.key == 'Escape' || event.key == "Backspace") && $(".flex_align_justify").is(':visible')) {
            setEleVisible(false, $(".ShowBankUI"));
            setEleVisible(false, $(".flex_align_justify"));
            $.post(`https://ATM/close`, JSON.stringify({}));
        }
    });
}))