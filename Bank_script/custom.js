
// post functions
$(document).ready(()=> {


    const elements = {
        showBankUI: $(".ShowBankUI"),
        showBankUI2: $(".flex_align_justify"),
        confirmDecline: $(".confirmDecline"),
        confirmtransactions: $(".confirmtransactions"),
        criditcard: $('.DebitCard'),

        interface: {
            access: $(".Access"),
            accept: $(".Accept"),
            newName: $(".NewName"),
            poofAccount: $(".PoofAccount"),
            collectPlaycheck:$( ".collectPlaycheck"),
            openUIPage: $(".openUIPage"),
            debitCard: $(".DebitCard"),
            close: $(".close")
        }
    }

    setEleVisible(false, elements.showBankUI);
    setEleVisible(false, elements.showBankUI2);
    setEleVisible(false, elements.criditcard);

    elements.interface.openUIPage.click(() => {
        setEleVisible(elements.showBankUI2, true);
    });

    window.addEventListener("message", (event) => {
        const item = event.data;
        if (!item || !item.type) return; // Prevent errors

        switch (ite.type) {
            case "openBankUI":
                setEleVisible(elements.showBankUI, true);
                setEleVisible(elements.showBankUI2, false);
                break;

            case "closeBankUI":
                setEleVisible(elements.showBankUI, false);
                setEleVisible(elements.showBankUI2, false);
                break;

            case "showBankUI":
                setEleVisible(elements.showBankUI, true);
                break;

            case "hideBankUI":
                setEleVisible(elements.showBankUI, false);
                setEleVisible(elements.showBankUI2, false);
                break;

            default:
                console.log("Unknown action: " + type);
                break;
        }
    });

    function setEleVisible(state, el) {
        state ? $(el).fadeIn() : $(el).fadeOut();
    }

    elements.confirmDecline.click(() => {

        $.post(`https://CustomBank_script/sound`, JSON.stringify({}));
    });

    elements.confirmtransactions.click(() => {
        $.post(`https://CustomBank_script/sound`, JSON.stringify({}));
    });

    let action = ""; // Declare action variable at the top scope

    elements.confirmtransactions.click(function () {
        $.post(`https://CustomBank_script/sound`, JSON.stringify({}));
        $.post(`https://CustomBank_script/useATM`, JSON.stringify({
            action: action,
            amount: $("#Deposit").val(),
            transaction: $("#Withdraw").val(),
            transferamount: $("#Transfer").val(),
            Targetid: $("#TargetID").val()
        }));
        $("#Deposit").val("");
        $("#Withdraw").val("");
        $("#Transfer").val("");
        $("#TargetID").val("");
        return false;
    });

    // Manage access
    elements.interface.access.click(() => {
        $.post(`https://CustomBank_script/sound`, JSON.stringify({}));
        $.post(`https://CustomBank_script/Access`, JSON.stringify({}));
    });


    // User Account
    elements.interface.accept.click(() => {
        $.post(`https://CustomBank_script/sound`, JSON.stringify({}));
        $.post(`https://CustomBank_script/Accept`, JSON.stringify({}));
    });

    // Manage Rename Account 
    // Re name account
    elements.interface.newName.click(() => {
        $.post(`https://Bank_script/sound`, JSON.stringify({}));
        $.get(`https://Bank_script/NewName`);
    });

    // confirm Button

    elements.interface.poofAccount.click(() => {
        $.post(`https://Bank_script/sound`, JSON.stringify({}));
        $.post(`https://Bank_script/PoofAccount`, JSON.stringify({}));
    elements.interface.collectPlaycheck.click(() => {
        $.post(`https://Bank_script/collectPlaycheck`, JSON.stringify({}));
    });
        $.post(`https://Bank_script/collectPlaycheck`, JSON.stringify({}))
    });

    elements.interface.collectPlaycheck.click(() => {
        $(".ShowBankUI").slideDown();
        $(".ShowBankUI").fadeOut();
    });

    elements.interface.openUIPage.click(() => {
        $(".flex_align_justify").slideDown();
        $(".flex_align_justify").fadeIn();

        setTimeout(() => {
            $(".ShowBankUI").fadeOut();
        }, 500);
    });

    elements.interface.debitCard.click(() => {
        $.post(`https://Bank_script/DebitCard`, JSON.stringify({}))
    });

    elements.interface.close.click(() => {
        $(".flex_align_justify").slideUp();
        $(".flex_align_justify").fadeOut()
    });

    elements.interface.close.click(() => {
        $.post(`https://Bank_script/close`, JSON.stringify({}));
    });

    $("button[type=submit]").click(function () {
        action = $(this).text();
    });

    $("button[type=submit]").click(() => {
        action = $(this).text();
    })
    
    window.addEventListener("keyup", ( event ) => {
        if ( event.key === "escape") {
        setEleVisible(false, $(".ShowBankUI"));
        setEleVisible(false, $(".flex_align_justify"));
            $.post('https://Bank_script/closeUI', JSON.stringify({}));
        }
        

        if ((event.key == 'Escape' || event.key == "Backspace") && $(".flex_align_justify").is(':visible')) {
            setEleVisible(false, $(".ShowBankUI"));
            setEleVisible(false, $(".flex_align_justify"));
            $.post(`https://Bank_script/close`, JSON.stringify({}));
        }
    });
});

