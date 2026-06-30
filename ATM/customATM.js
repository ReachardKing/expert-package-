
const tab_lists = document.querySelectorAll(".table_list ul li");
const tab_items = document.querySelectorAll(".table_item");

tab_lists.forEach(function (list) {
    list.addEventListener("click", function () {
        const tab_data = list.getAttribute("data-tc");

        tab_lists.forEach(function (list) {
            list.classList.remove("active");
        });

        list.classList.add("active");

        tab_items.forEach(function (item) {
            const tab_class = item.getAttribute("class").split(" ");
            if (tab_class) {
                if (tab_class.includes(tab_data)) {
                    item.style.display = "block";
                } else {
                    item.style.display = "none";
                }
            }
        })
    })
})

// Fadein / out transitions

$(document).on("click", ".fa-right-from-bracket", () => {
    $("#confirmButton").fadeOut()
})

$(document).on("clcik", ".confirmDecline", () => {
    $(".customoption").fadeOut()
})

$(document).on("click", ".confirmtransactions", () => {
    $(".customoption").fadeOut()
})

$(document).on("click", ".customTransfer", () => {
    $(".customoption").fadeIn();
    $(".customoption").slideDown();
})

// UI Display

// Delete screen
$("#Successful").hide(); $("#Failed").hide(); $("#Deleted").hide(); $("#confirmButton").hide();

function HideAllOtherContent(bool) {
    if (bool) {
        $(".flex_align_justify, #confirmButton, #Successful, #Failed").hide()
    }
}

HideAllOtherContent(false);

$(document).on("click", ".fa-solid", () => {
    $("#Deleted").slideDown();
    $("#Deleted").fadeIn();
})

$(document).on("click", "#Deleted", () => {
    HideAllOtherContent(true);
})

$(document).on("click", ".fa-right-from-bracket", () => {
    $("#confirmButton").slideDown();
    $("#confirmButton").fadeIn();

    setTimeout(() => {
        $("#confirmButton").slideUp();
        $("#confirmButton").fadeOut();
    }, 3500)
})

$(document).on("click", ".KeepAccount", () => {
    setTimeout(() => {
        $("#confirmButton").slideUp();
        $("#confirmButton").fadeOut();
    }, 3500)
})

$(document).on("click", ".PoofAccount", () => {
    setTimeout(() => {
        $("#confirmButton").slideUp();
        $("#confirmButton").fadeOut();
    }, 3500)
})

$(document).on("click", ".confirmtransactions", () => {
    $("#Successful").slideDown();
    $("#Successful").fadeIn();

    setTimeout(() => {
        $("#Successful").slideUp();
        $("#Successful").fadeOut();
    }, 3500)
})

$(document).on("click", ".confirmDecline", () => {
    $("#Failed").slideDown();
    $("#Failed").fadeIn();
    setTimeout(() => {
        $("#Failed").slideUp();
        $("#Failed").fadeOut();
    }, 3500)
})