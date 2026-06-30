// [ Breathalyzer Script 0.1 Created By JKSensation ] //
// [ DO NOT RELEASE/LEAK/SHARE CODE WITHOUT PERMISSION FROM JKSENSATION ] //

$(document).ready(function() {
    const elements = {
        container: $("#container"),
        infotext: "UI",
        infodata: "data"
    };

    showElement(false, elements.container);

    function showElement(status, el) 
    {
        status ? el.fadeIn() : el.fadeOut();
    }

    window.addEventListener('message', function(event) {
        const payload = event.data;
        const type = payload.type || payload.action;
        const item = payload.item || payload;

        switch (type) {
            case elements.infotext:
                showElement(true, elements.container);
                break;
            case elements.infodata:
                showElement(true, $("#data"));
                $('#bacLevel').text(item.bac || "");
                $('#bacLevel').css("color", item.textColor ? `var(${item.textColor})` : "");
                break;
            default:
                break;
        }
    })

    document.onkeyup = function (data) {
        if (data.key === "Escape") {
            $.post('http://breathalyzer/exit', JSON.stringify({}));
            return
        }
    };

    $("#power").click(function () {
        $.post('http://breathalyzer/exit', JSON.stringify({}));
        return
    })

    $("#start").click(function () {
        $.post('http://breathalyzer/startBac', JSON.stringify({}));
        return
    })

});