
// Alocate time     

$("#manage-Active-marker-holder, #manage-Notes-marker-holder, #manege-Degital-References-holer, #manage-Bail-Hearing-holder, #manageAliases-Affliations-holder, #manage-photo-holder").append(` No Data `);

// Gather Ifo
$(document).ready(() => {

    const time = new Date()

    // Title, information, tags, officer, involed, civ incolved, eveidence   
    const title = $("#manage-incidents-title-input").val()
    const Debrief = $("#Incdent-Debrif").val()
    const tags = $("#manage-incident-tags-input").val()
    const role = $("#manage-seleced-options").val()
    const Aditional = $("#manage-incidens-reports-content").val()
    const IncentID = $("#manage-icident-id").val()
    const InputCharges = $("#manage-input-fine, #manage-input-time").val() // fine & time
    const PlayerPleabox = $(".Save, .Save-jail").val()

    const table_rows = [title, tags, Debrief, role, Aditional, IncentID, InputCharges, time, PlayerPleabox];

    setInterval((data) => {
        if(table_rows === "WIP" || table_rows === "PENDING" || table_rows === " ") {
            $(".success-error").html(`<div id="correctIncient" style="width: 100%; position: absolute; background: transparent; border: 2px solid blue; transition: 0.5s; cursor: pointer;">${IncentID} - remains ${table_rows[data]}</div> `);
            $(".success-error").css("border", "5px solid crimson");
        } else {
            $(".success-error").css("border", "5px solid transparent");
        }
    }, 35000);
    

    $(document).on("click", "#correctIncient", ()=> {
        $(this).data("manage-icident-id");
    })

    $(document).on("click", ".open-evidence-locker", (open) => {
        $.post(`https://NamelessmDT/openevidencelocker`, JSON.stringify({open: open}))
    })

    let profile = $("#search-button").val()
    if (profile != '') {
        $.post(`https://NamelessMDT/searchProfile`, JSON.stringify({ profile: profile}))
        $.post(`https://NamelessMDT/searchVehicles`, JSON.stringify({ profile: profile}))
    }

    $.post(`https://NamelessMDT/SearchWeapon`, JSON.stringify({}))
        
    
    $(document).on("click", ".open-fixed-reports", ()=> {
        $.post(`https://NamelessMDT/getAllIncidents`, JSON.stringify({table_rows: table_rows}))
    })

    $(".close").click(function (e) {
        $.post(`https://NamelessMDT/close`, JSON.stringify({}))
    });

    $(".Save, .Save-jail").click(() => {
        $.post(`https://NamelessMDT/SaveIncident`, JSON.stringify({ table_rows: table_rows}))
        $.post(`https://NamelessMDT/Processed`, JSON.stringify({ table_rows: table_rows}))
    })

    $(".checkmark").click(() => {
        $("#manage-civilians-info-boxes, #manage-crime-info-boxes").slideUp();
        $("#manage-civilians-info-boxes,  #manage-crime-info-boxes").fadeOut();
    })

    $("#manage-incidents-Created").append(time);

    $.post(`https://NamelessMDT/PointSystem`, JSON.stringify({}));
});

// Example: Call showLicense with the specific license you want to show

$(document).on("click", ".incident-container", function () {
    const incidentId = $(this).text(); // Or use .val() if it's an input field

    // Create a temporary input element to copy the text to the clipboard
    navigator.clipboard.writeText(incidentId).then(function () {
        alert("Incident ID copied to clipboard!");
    }).catch(function (err) {
        console.error("Failed to copy text: ", err);
    })
})

// 
$(document).ready(() => {
    let showlockscrool = `<i onclick="showLockScrool()" class="fa-solid fa-lock-open" id="showlockscrool-lock"></i>`;

    function showLockScrool(preventScroll) {
        const lockElement = $("#showlockscrool-lock");
        lockElement.toggleClass("fa-solid fa-lock");
        lockElement.hidden = !lockElement.hidden;
        window.remoeveEventListener("scroll", preventDefault, { passive: false });
    };

    function preventDefault(e) {
        e.preventDefault();
    };


})