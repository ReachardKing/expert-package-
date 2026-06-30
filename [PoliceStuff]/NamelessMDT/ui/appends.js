
const element = {
	background: $(".MDTbackground")
};

function SetElement(state, el) {
	state ? el.fadeIn() : el.fadeOut();
}

SetElement(false, element.background); // Show on load
SetElement(false, $(".EMSbackground")); // Hide on load

window.addEventListener("message", (event) => {
	const item = event.data;

	switch (item.type || item.action) {
		case "MDT":
			SetElement(true, element.background); // Corrected: show
			break;
		case "remove":
			SetElement(false, element.background); // Corrected: hide
            SetElement(false, $(".EMSbackground"))
			break;
        case "EMSMDT":
            SetElement(true, $(".EMSbackground")); // Show EMS MDT
		default:
			break;
	}

	const playerName = document.getElementById("PlayerName");
	if (playerName) playerName.textContent = item.PlayerName || "";
});


// Display content 
window.addEventListener("DOMContentLoaded", (event)=> {
    $(".rightpanelSearchName, .displaynamecontent, .displayvehiclecontent, .displayWeaponcontent, .displayCrimecontent, .displayincidentcontent, .displaypointsystem, .CustompointsSettings, .Audit-content-section, .LEORoster, .LEOSOP, .LEOPenalCode, #Settingsarea, .rightpanelLivechat, .import-all-crime-info, .manage-incidents-container, .manage-civilians-info-box, #rolemanagement, .manage-crime-info-box, .No-data, .search-workspace, .No-data, .floatting-btn, .show-ten-codes").each(function() {
        $(this).hide();
    });

    event.preventDefault();
    
    $(document).on("keydown", function (event) {

        // SHIFT + F
        if (event.shiftKey && event.key.toLowerCase() === "f") {

            // Prevent duplicate creation
            if (!$(".search-workspace").length) {
                $("body").append(`
                    <div class="search-workspace">
                        <input type="text" 
                            style="width: 100%; margin-bottom: 5px;" 
                            placeholder="search content in this workspace" 
                            class="search-input">
                    </div>
                `);
            } else {
                $(".search-workspace").show();
            }
        }

        // ESC key
        if (event.key === "Escape") {
            $(".search-workspace").hide();
            $(".search-input").val("");
        }
    });
    
    // const inputfield = [".search-button", "#manage-civilian-input", "#manage-crime-input"];
    
})

document.addEventListener("click", (e) => {
    if (e.target.matches(".open-profile-content")) {
        document.getElementById("Namecontent").style.display = "block";
    }
});

document.addEventListener("click", (e) => {
    if (e.target.matches(".fa-random")) {
        $(".spinner").fadeIn(500)
        $(".spinner").fadeOut(800)
    }
});

document.addEventListener("click", (e) => {
    if (e.target.matches(".SearchName, .SearchVehicle")) {
        $(".SearchNameDefualt").text(" ");
        $(".spinner").fadeIn(600);
        $(".rightpanelSearchName").fadeIn(800);
        $(".spinner").fadeOut(800);
    }
});

document.addEventListener("click", (e) => {
    if (e.target.matches(".SearchWeapon")) {
        $(".rightpanelSearchName").fadeOut(800);
        $(".displayWeaponcontent").fadeIn(800);
    }
});


document.addEventListener("click", (e) => {
    if (e.target.matches(".CrimalMnagement")) {
        $(".displayWeaponcontent").fadeOut();
        $(".rightpanelSearchName").fadeOut(800);
        $("#SearchCrimecontent").fadeIn(800);
    }
});

document.addEventListener("click", (e) => {
    if (e.target.matches(".Point-system")) {
        $("#PointSystemcontent").fadeIn();
    }
});

document.addEventListener("click", (e) => {
    if (e.target.matches(".CustomRoster")) {
        $("#LEOSystemcontent").fadeIn();
    }
});

document.addEventListener("click", (e) => {
    if (e.target.matches(".LEO-System")) {
        $("#SOPSystemcontent").fadeIn();
    }
});

document.addEventListener("click", (e) => {
    if (e.target.matches(".PenalCode")) {
        $("#Penalstemcontent").fadeIn();
    }
});

document.addEventListener("click", (e) => {
    if (e.target.matches(".floatintbutton")) {
       $(".rightpanelSearchName").fadeOut(800);
       $(".Audit-content-section").fadeIn(800)
    }
});

document.addEventListener("click", (e) => {
    if (e.target.matches(".audit-close")) {
       $(".Audit-content-section").fadeOut()
    }
});

document.addEventListener("click", (e) => {
    if (e.target.matches(".IncidentReoprt")) {
        $(".rightpanelSearchName").fadeOut(800);
        $("#Incidentscontent").fadeIn(800);
    }
});

document.addEventListener("click", (e) => {
    if (e.target.matches(".IncidentReoprt, .Point-system, .CustomRoster, .LEO-System, .PenalCode, .MainSettings")) {
        $(".rightpanelSearchName").fadeOut(800);
        $('#SearchCrimecontent').fadeOut(800);
    }
});

const menus = [".custom-active-warrents", ".custom-active-Notes", ".custom-degital-reference", ".custom-Bail-Hearing", ".custom-Aliases-Affliations", ".custom-photes"];

function displayMenus(means, status) {
    if (status) {
        menus.forEach(element => $(element).hide());
        $(means).fadeIn();
    } else {
        $(means).fadeOut();
    }
}

document.addEventListener("click", (e) => { if (e.target.matches(".manage-active-marker-add-btn")) { displayMenus(".custom-active-warrents", true) } });
document.addEventListener("click", (e) => { if (e.target.matches(".manage-profile-notes-add-btn")) { displayMenus(".custom-active-Notes", true) } });
document.addEventListener("click", (e) => { if (e.target.matches(".manage-Degital-references-add-btn")) { displayMenus(".custom-degital-reference", true) } });
document.addEventListener("click", (e) => { if (e.target.matches(".manage-Bail-hearing-add-button")) { displayMenus(".custom-Bail-Hearing", true) } });
document.addEventListener("click", (e) => { if (e.target.matches(".manage-Aliases-Affliations-add-btn")) { displayMenus(".custom-Aliases-Affliations", true) } });
document.addEventListener("click", (e) => { if (e.target.matches(".manage-profiles-potoes-add-btn")) { displayMenus(".custom-photes", true) } });
document.addEventListener("click", (e) => { if (e.target.matches(".Warrents-save")) { displayMenus(".custom-active-warrents", false) } });
document.addEventListener("click", (e) => { if (e.target.matches(".Notes-save")) { displayMenus(".custom-active-Notes", false) } });
document.addEventListener("click", (e) => { if (e.target.matches(".Degital-Reference-saves")) { displayMenus(".custom-degital-reference", false) } });
document.addEventListener("click", (e) => { if (e.target.matches(".Bail-Hearing-save")) { displayMenus(".custom-Bail-Hearing", false) } });
document.addEventListener("click", (e) => { if (e.target.matches(".Aliases-Affliations-save")) { displayMenus(".custom-Aliases-Affliations", false) } });
document.addEventListener("click", (e) => { if (e.target.matches(".Photoes-save")) { displayMenus(".custom-photes", false) } });
document.addEventListener("click", (e) => { if (e.target.matches(".MDT-close")) { $.post(`https://NamelessMDT/close`, JSON.stringify({})) } });
function CreateIncidentReportCID(length) { 
    const CID = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    return Array.from({length}, () => CID[Math.floor(Math.random() * CID.length)]).join('');
}
document.addEventListener("click", (e) => { if (e.target.matches(".Create-incident, .fa-plus-circle")) { $(".manage-incidents-container").fadeIn(); $("#manage-icident-id").html(` - <span>${CreateIncidentReportCID(15)}</span> `) } });
document.addEventListener("click", (e) => { if (e.target.matches(".manage-officer-names")) { $("#rolemanagement").fadeIn() } });
document.addEventListener("click", (e) => { if (e.target.matches(".manage-suspect-edit")) {
    $("#opensendoff").fadeIn();
    $("#manage-seledted-ptions").val();
    $("#suspect-charges-holder").val();
    $("#manage-input-charges").val();
    $("#manage-input-time").val();
    $("#PlayerID").val();
    $(".Save-jail").val();
} });

document.addEventListener("click", (e) => { if (e.target.matches(".manage-suspect-view")) { $("#opensendoff").fadeIn() } });

document.addEventListener("click", (e) => { if (e.target.matches(".open-fixed-reports")) { $(".manage-incidents-container").fadeIn() } });

document.addEventListener("click", (e) => { if (e.target.matches(".open-incident-info")) { $("#opensendoff").fadeIn(); $("#manage-civilians-info-boxes").fadeOut() } });

document.addEventListener("click", (e) => { if (e.target.matches(".open-crime-info")) { $("#manage-crime-info-boxes").fadeIn() } });

document.addEventListener("click", (e) => { if (e.target.matches(".MainSettings")) { $("#Settingsarea").fadeIn() } });

document.addEventListener("click", (e) => { if (e.target.matches(".livechats")) { $(".rightpanelLivechat").fadeIn(); $("shortcuts-keys").hide()} });

document.addEventListener("click", (e) => { if (e.target.matches(".Civilians-section")) { $(".manage-civilians-info-box").fadeOut() } });

document.addEventListener("click", (e) => { if (e.target.matches(".process-section")) { $("#manage-crime-info-boxes").fadeOut() } });

document.addEventListener("click", (e) => { if (e.target.matches(".update-crime-info")) { $("#manage-crime-info-boxes").fadeOut() } });

document.addEventListener("click", (e) => { if (e.target.matches(".role-section")) { $("#rolemanagement").fadeOut(); $("#opensendoff").fadeOut() } });

document.addEventListener("click", (e) => { if (e.target.matches(".Save")) { $(".spinner").fadeIn(1800); $(".spinner").fadeOut(1800) } });

document.addEventListener("click", (e) => { if (e.target.matches(".Save-jail")) { $(".spinner").fadeIn(1800); $(".spinner").fadeOut(1800) } });

document.addEventListener("click", (e) => { if (e.target.matches(".checkmark")) { $(".spinner").fadeIn(1800); $(".sppinner").fadeOut(800) } });

document.addEventListener("click", (e) => { if (e.target.matches(".crime-section")) { $(".import-all-crime-info").fadeOut() } });

document.addEventListener("click", (e) => { if (e.target.matches(".cancel-input-content")) { $(".manage-active-notes").fadeOut() } });

document.addEventListener("click", (e) => { if (e.target.matches(".cancel-input-content")) { $("#manage-active-warrents").fadeOut() } });

document.addEventListener("click", (e) => { if (e.target.matches(".div-close")) { $(".manage-incidents-container").fadeOut() } });

document.addEventListener("click", (e) => { if (e.target.matches(".Civilians-section")) { $(".manage-civilians-info-box").fadeOut() } });

document.addEventListener("click", (e) => { if (e.target.matches(".hide-section")) { $(".displaynamecontent").fadeOut() } });

document.addEventListener("click", (e) => { if (e.target.matches(".hide-section")) { $(".displayvehiclecontent").fadeOut() } });

document.addEventListener("click", (e) => { if (e.target.matches(".manage-license-revoke")) { $("#SearchWeaponcontent").fadeOut() } });

document.addEventListener("click", (e) => { if (e.target.matches(".crime-close")) { $("#SearchCrimecontent").fadeOut() } });

document.addEventListener("click", (e) => { if (e.target.matches(".incident-close")) { $("#Incidentscontent").fadeOut() } });

document.addEventListener("click", (e) => { if (e.target.matches(".system-close")) { $("#PointSystemcontent").fadeOut() } });

$(document).on("click", ".Edit-close", function () {
    $(".CustompointsSettings").fadeOut();
});

$(document).on("click", "#point-settings", ()=> {
    $(".CustompointsSettings").fadeIn();
})

$(document).on("click", ".Roster-close", function () {
    $("#LEOSystemcontent").fadeOut();
});

$(document).on("click", ".SOP-close", function () {
    $("#SOPSystemcontent").fadeOut();
})

$(document).on("click", ".Penal-close", ()=> {
    $("#Penalstemcontent").fadeOut();
})

$(document).on("click", "#MainSettingclose", ()=> {
    $("#Settingsarea").fadeOut();
});

$(document).on("click", ".Radar, .interface", function () { $(".rightpanelLivechat").fadeOut(); });

$(document).on("click", "#leftbuttons", function () {
    $("#Settingsarea").fadeOut();
});

// Needs a huge over all not what i'm looking for

const roles = [
    { key: "suspect", value: "Special", label: "Suspects" },
    { key: "officer", value: "officer", label: "Officer" },
    { key: "victim", value: "Victim", label: "Victim" },
    { key: "witness", value: "Witness", label: "Witness" },
    { key: "medical", value: "Medical", label: "Medical" },
    { key: "others", value: "others", label: "Others" }
];

function renderContainers(selectedRoleKey ) {
    const selectedRole = roles.find(role => role.value === selectedRoleKey);
    
    // Ensure we only display the default "Special" role unless another one is selected
    const validRoles = selectedRole ? [selectedRole] : roles.filter(r => r.key === "suspect");

    // Generate containers only for valid roles
    const containerHTML = validRoles.map(({ key, value }) => GenerateContainerHTML(key, value)).join("");
    $(".Handles-profile-crime-info").append(containerHTML);
};

function GenerateContainerHTML(key, roleLabel, data, actions = true) {
    return `
        <p style="outline: auto; background: black; text-align: center;">${roleLabel}</p>
        <div id="${key}" class="role-container" data-role="${key}"></div>
        <hr>
        <p style="text-align: left; font-size: 11px;">${escapeHtml(data?.name || "Not found")}</p>
        <p style="text-align: left; font-size: 11px;">${escapeHtml(data?.CSN || "Not found")}</p>
        <hr class="EditTopTextline">
        ${actions ? `
            <button class="CreateButtonView"><i class="open-rendercontent fas fa-eye"></i></button>
            <button class="ViewButtonEdit"><i class="fa-solid fa-pen-to-square"></i></button>
            <button class="createdButtonDelete"><i class="fas fa-trash-alt"></i></button>
        ` : ""}

    `;
}

// Handle selection change
$(document).on("change", "#manage-selected-options", function () {
    const selectedRoleKey = $(this).val() || $(this).data("role");

    if (selectedRoleKey) {
        renderContainers(selectedRoleKey);
    }

    $("#rolemanagement").hide();
    $(".manage-civilians-info-box").fadeIn(500);
});

// Handle rolemanagement open event
$(document).on("click", ".open-rendercontent", function () {
    $("#opensendoff").fadeIn();
});

$(document).on("click", ".fa-trash-alt", function () {
   $(this).remove();
});

$(document).on("click", ".update-crime-info", function () { 
    
    var selectedRow = $(this).closest("tr");

    var crimeData = extractsuspectCrime(selectedRow);

    appendToSuspectChargesHolder(crimeData);
});

function extractsuspectCrime(row) { 
    if(!row || typeof row.find !== 'function') return null;

    return {
        crime: escapeHtml(row.find("td:nth-child(1)").text().trim()),
        fine: escapeHtml(row.find("td:nth-child(2)").text().trim()),
        jailTime: escapeHtml(row.find("td:nth-child(3)").text().trim()),
        modify: `<button class="display-susect-crime-outcome">Aggravated</button><button
                class="display-susect-crime-outcome">Attempted</button><button
                class="display-susect-crime-outcome">Accomplice</button><button
                class="display-susect-crime-outcome">Accessory</button><button
                class="display-susect-crime-outcome">Conspiracy</button><button
                class="display-susect-crime-outcome">Fenoly</button>`
    }
}

function appendToSuspectChargesHolder(crimeData) { 
    if(!crimeData) return null;

    var newRow = `<table style="width: 800px;  color: rgb(255, 255, 255); text-align: center;" id="manage-table-content">
                <tr>
                    <th onclick="sortTable(0, 'manage-table-content')">Crime</th>
                    <th onclick="sortTable(1, 'manage-table-content')">Fine </th>
                    <th onclick="sortTable(2, 'manage-table-content')">JailTime </th>
                    <th onclick="sortTable(3, 'manage-table-content')">Available Modifiers</th>
                    <th onclick="sortTable(4, 'manage-table-content')">counts</th>
                    <th>Remove charges</th>
                </tr>
                <tr>
                    <td style="margin:0 20px; padding: 0 20px">${crimeData.crime}</td>
                    <td style="margin:0 20px; padding: 0 20px">${crimeData.fine}</td>
                    <td style="margin:0 20px; padding: 0 20px">${crimeData.jailTime}</td>
                    <td style="margin:0 20px; padding: 0 20px">${crimeData.modify}</td>
                    <td style="margin:0 20px; padding: 0 20px"><div class="custominput"><span class="minus">-</span><span class="num">0</span><span class="plus">+</span></div></td>
                    <td style="margin:0 20px; padding: 0 20px"><button class="createdButtonDelete"><i class="Removecurrentcharges fa fa-trash-alt" style="background: var(--color-3); color: var(--color-2); cursor: cell; float:right;"></i></button></td>
                </tr>
            </table>`;
    $('.suspect-charges-holder').append(newRow);
};

$(document).on("click", ".Removecurrentcharges", function () {
    $(this).closest("tr").remove(); // Use 'tr' if you want to remove only the row, or adjust as needed
    $(this).closest("td").remove(); // Use 'td' if you want to remove only the row, or adjust as needed
});

$(document).on("click", ".Removecurrentcharges", function () {
    $(this).closest("tr").remove(); // Use 'tr' if you want to remove only the row, or adjust as needed.
    $(this).closest("td").remove();
});

$(document).on('click', '.Save-jail', function () {
    // Step 1: Select the closest row and extract data once
    var selectedRow = $(this).closest("tr");
    var crimeData = extractCrimeData(selectedRow);

    // Step 2: Append new row with incident details
    appendToIncidentChargesHolder(crimeData);
});

// Step 3: Extract crime data
function extractCrimeData(row) {
    if(!row || typeof row.find !== 'function') return null;

    return {
        Title: escapeHtml(row.find("input:nth-child(1)").text().trim()),
        Tags: escapeHtml(row.find("input:nth-child(2)").text().trim())
    };
}

// Step 4: Append new row to Incident Charges holder
function appendToIncidentChargesHolder(crimeData) {
    if(!crimeData) return null;

    const existingRow = $(".mange-Incident-Report-container").find(`td:contains(${crimeData.Title})`);
    if (existingRow.length > 0) {
        console.warn("Row already exists, skipping append.");
        return;
    }
    // Build the new row with template literal
    var newRow = `<table style="width:1055px; padding:0 20px;" id="manage-table-content">
            <tr>
                <th onclick="sortTable(0, 'manage-table-content')">Title</th>
                <th onclick="sortTable(1, 'manage-table-content')">Tags</th>
                <th onclick="sortTable(2, 'manage-table-content')">Date</th>
                <th onclick="sortTable(3, 'manage-table-content')">Incident Actions</th>
            </tr>
            <tr>
                <td style="margin:0 20px; padding: 0 20px">${crimeData.Title}</td>
                <td style="margin:0 20px; padding: 0 20px">${crimeData.Tags}</td>
                <td style="margin:0 20px; padding: 0 20px">${Currentdate}</td>
                <td style="margin:0 20px; padding: 0 20px"><i class="open-fixed-reports fas fa-eye"></i></td>
            </tr>
        </table>`;
        // Append to the container (avoid prepending the same row twice)
        $(".mange-Incident-Report-container").append(newRow);
}

$(document).on("click", ".fa-image", function () {
    
    const imageinput = document.createElement("input")
    imageinput.type = "text"

    if(imageinput || imageinput.length > 0) {
        return;
    }

    const file = imageinput.files[0];
    const regex = /\.(jpg|jpeg|png|gif)$/i;

    if(!regex.test(file.name)) {
        alert("Please upload a valid image file (jpg, jpeg, png, gif).")
        return;
    }

    const imageUrl = URL.createObjectURL(file); 
    
    appendImageToIncidentDebrif(imageUrl); 
});

function appendImageToIncidentDebrif(imageUrl) {
    $("#Incident-Debrif").html(`<input type="input" src="${imageUrl}" placeholder="Image URL">`);
};

const TenCodes = {
    "Signal 60": "Drugs operation",
    "Code Zero": "Game Crash",
    "Code 4": "Under Control",
    "Code 6": "Looking for evidence / suspect / victims",

    "10-0": "Hold all but emergency traffic",
    "10-1": "Frequency Change",
    "10-2": "Signal Good",
    "10-3": "Stop Transmitting",
    "10-4": "Affirmative",
    "10-5": "Meal Break (Burger Shot etc.)",
    "10-6": "Busy",
    "10-7": "Out of Service",
    "10-8": "In Service",
    "10-9": "Repeat",
    "10-10": "Fight in Progress",
    "10-11": "Traffic Stop",
    "10-12": "Active Ride Along",
    "10-13": "Shots Fired",
    "10-15": "Subject in custody en route to Station",
    "10-16": "Stolen Vehicle",
    "10-17": "Suspicious Person",
    "10-18": "Running Radar",
    "10-19": "Hostage status",
    "10-20": "Location",
    "10-21": "Prison Break",
    "10-22": "Disregard",
    "10-23": "Arrived on Scene",
    "10-25": "Domestic Dispute",
    "10-26": "ETA",
    "10-27": "Driver License Check",
    "10-28": "Vehicle License Plate Check",
    "10-29": "NCIC Warrant Check",
    "10-30": "Wanted Person",
    "10-31": "Not Wanted / No Warrants",
    "10-32": "Request Backup (Code 1-2-3)",
    "10-33": "Undercover Vehicle",
    "10-35": "Units on scene / sufficient",
    "10-37": "Courtesy Ride",
    "10-39": "Felony Stop",
    "10-41": "Beginning Tour of Duty",
    "10-42": "Ending Tour of Duty",
    "10-43": "Giving Information on radio",
    "10-44": "Injured person Report",
    "10-45": "Status check",
    "10-46": "Civilian Report Check",
    "10-48": "Felony Stop / High Risk Stop",
    "10-49": "Homicide",
    "10-50": "Vehicle Accident: Suspect Vehicle Crashed",
    "10-51": "Request Towing Service",
    "10-52": "Request EMS & Fire Department",
    "10-53": "Mental patient — respond immediately",
    "10-55": "Intoxicated Driver",
    "10-56": "Intoxicated Pedestrian",
    "10-57": "Private Talk",
    "10-59": "Roll Call",
    "10-60": "Armed with a Gun",
    "10-61": "Armed with a Knife",
    "10-62": "Kidnapping",
    "10-65": "Escorting Prisoner",
    "10-66": "Reckless Driver",
    "10-67": "Arson",
    "10-68": "Armed Robbery",
    "10-70": "Foot Pursuit",
    "10-71": "Request Supervisor",
    "10-73": "Advise Status",
    "10-80": "Vehicle Pursuit",
    "10-90": "Rehire Fired Officer",
    "10-91": "Recently Hired Officer",
    "10-93": "Fired Officers",
    "10-97": "En Route",
    "10-98": "Officer in Distress — Extreme Emergency",
    "10-99": "Cadet Training",
    "11-44": "Person Deceased",

    "Priority 1": "Highest priority transport",
    "Priority 2": "Medium priority transport",
    "Priority 3": "Low priority transport"
};
function buildTenCodesHTML() {
    let html = `<div class="display-ten-code">`;

    for (const code in TenCodes) {
        html += `
            <p><strong>${code}</strong> - ${TenCodes[code]}</p>
        `;
    }

    html += `</div>`;
    return html;
}

$(document).on("click", ".Ten-codes", ()=> {
    $(".show-ten-codes").fadeIn();
    $(".show-ten-codes").html(buildTenCodesHTML())
})

$(document).on("click", ".Display-options", function(){
    $(".floatting-btn").fadeIn();
    $(".floatting-btn").html(`
        <div class="main-options">
            <button class="option-btn">Imports</button>
            <button class="option-btn">Exports</button>
            <i class="fa-solid fa-right-from-bracket" style="float: right; cursor: cell; color:  white; background: rgba(138, 50, 50, 1);"></i>
        </div>    
    `)
    
})

$(document).on("click", ".option-btn", ()=> {
    $(".floatting-btn").fadeOut();
})

$(document).ready(function () {

    // View more info on charges

    $(document).on("click", ".AninalCurlty", function () {
        $(".import-all-crime-info").fadeIn();
        $(".import-all-crime-info").html(`
            <div class="Criminal-records">
                <div class="form-records-content">
                    <button class="crime-section" style="font-size: 24px; cursor: cell; position: absolute; right: 10px; top: 5px; background: transparent; border: none; color: purple; font-weight: 600; text-align: center; border-radius: 50%;">&times;</button>
                    <input type="text" placeholder="Aninal Curlty" readonly>
                    <textarea placeholder="" readonly></textarea>
                    <div class="forms-records-infos">
                      <input type="number" id="manage-input-charges" placeholder="" readonly>
                        <input type="number" id="manage-input-time" placeholder="" readonly>
                    </div>
                </div>
            </div>`)
    })

    // Penal Code (1) Crimes Against a person HR  (1) 01 to (1)-(16)

    $(document).on("click", ".CriminalHarassment", function () {

        $(".import-all-crime-info").fadeIn().html(`
            <div class="Criminal-records">
                <div class="form-records-content">
                    <button class="crime-section" style="font-size: 24px; cursor: cell; position: absolute; right: 10px; top: 5px; background: transparent; border: none; color: purple; font-weight: 600; text-align: center; border-radius: 50%;">&times;</button>
                    <p> Penal Code (1) Crimes Against a person HR (1) 01 to (1)-(16)</p>
                    <input type="text" placeholder="Criminal Harassment" readonly>
                    <textarea placeholder=" Criminal Harassment commonly  known as “Stalking” is the repeated following or or communicating with another person to the extent of following that said person to their workplace or in their vehicles.When the victim in question is constantly in  [fear, fearing] / being threatening to the victim, family member or or colleagues to fear for their safety is guilty of an indictable offense of $5 000 and 60 month imprisonment." readonly></textarea>
                    <div class="forms-records-infos">
                        <input type="number" id="manage-input-charges" placeholder="$5, 000" readonly>
                        <input type="number" id="manage-input-time" placeholder="60 month" readonly>
                    </div>
                </div>
            </div>
        `);
    })

    $(document).on("click", ".CriminalAssault", function () {
        $(".import-all-crime-info").fadeIn();

        $(".import-all-crime-info").html(`
            <div class="Criminal-records">
                <div class="form-records-content">
                    <button class="crime-section" style="font-size: 24px; cursor: cell; position: absolute; right: 10px; top: 5px; background: transparent; border: none; color: purple; font-weight: 600; text-align: center; border-radius: 50%;">&times;</button>
                    <p> Penal Code (1) Crimes Against a person HR (1) 01 to (1)-(16)</p>
                    <input type="text" placeholder="Criminal Assault" readonly>
                    <textarea placeholder="Simple assault is also known as “Assault” is the act of physical, mental or unwanted contact done to a victim, witness to the extent of death, paralyzed or hospitalized, this is an indictable offense when found guilty of 3, 00 and 55 month month impressment. This charge will change when it’s against an officer of the law, with the new fine of 8, 000 and 80 month imprisonment, also known as an aggravated charge." readonly></textarea>
                    <div class="forms-records-infos">
                        <input type="number" id="manage-input-charges" placeholder="$4,000" readonly>
                        <input type="number" id="manage-input-time" placeholder="60 month" readonly>
                    </div>
                </div>
            </div>
        `);
    })

    $(document).on("click", ".SimpleAssulat", function () {
        $(".import-all-crime-info").fadeIn();

        $(".import-all-crime-info").html(`
            <div class="Criminal-records">
                <div class="form-records-content">
                    <button class="crime-section" style="font-size: 24px; cursor: cell; position: absolute; right: 10px; top: 5px; background: transparent; border: none; color: purple; font-weight: 600; text-align: center; border-radius: 50%;">&times;</button>
                    <p> Penal Code (1) Crimes Against a person HR (1) 01 to (1)-(16)</p>
                    <input type="text" placeholder="Simple Assulat" readonly>
                    <textarea placeholder="Simple assault is also known as “Assault” is the act of physical, mental or unwanted contact done to a victim, witness to the extent of death, paralyzed or hospitalized, this is an indictable offense when found guilty of 3, 00 and 55 month month impressment. This charge will change when it’s against an officer of the law, with the new fine of 8, 000 and 80 month imprisonment, also known as an aggravated charge." readonly></textarea>
                    <div class="forms-records-infos">
                        <input type="number" id="manage-input-charges" placeholder="$8, 000" readonly>
                        <input type="number" id="manage-input-time" placeholder="90 month" readonly>
                    </div>
                </div>
            </div>
        `);
    })

    $(document).on("click", ".AssaultWAWeapon", function () {
        $(".import-all-crime-info").fadeIn();

        $(".import-all-crime-info").html(`
            <div class="Criminal-records">
                <div class="form-records-content">
                    <button class="crime-section" style="font-size: 24px; cursor: cell; position: absolute; right: 10px; top: 5px; background: transparent; border: none; color: purple; font-weight: 600; text-align: center; border-radius: 50%;">&times;</button>
                    <p> Penal Code (1) Crimes Against a person HR (1) 01 to (1)-(16)</p>
                    <input type="text" placeholder="Assault with a Weapon" readonly>
                    <textarea placeholder="Assault with a weapon carries use of threats to use a weapon or imitation thereof, this also means their gun has to be shown during the crime thereof, is found guilty of an indictable offense of 4, 000 and 60 month imprisonment. This charge is taken much more seriously than a common assault charge due to use of or threatened use of a weapon, which can cause serious bodily harm. This charge will change when it’s against an officer of the law, with the new fine of 8, 000 and 80 month imprisonment, also known as an aggravated charge." readonly></textarea>
                    <div class="forms-records-infos">
                        <input type="number" id="manage-input-charges" placeholder="$9, 000" readonly>
                        <input type="number" id="manage-input-time" placeholder="80 month" readonly>
                    </div>
                </div>
            </div>
        `);
    })

    $(document).on("click", ".AssulatOAPofficer", function () {
        $(".import-all-crime-info").fadeIn();

        $(".import-all-crime-info").html(`
            <div class="Criminal-records">
                <div class="form-records-content">
                    <button class="crime-section" style="font-size: 24px; cursor: cell; position: absolute; right: 10px; top: 5px; background: transparent; border: none; color: purple; font-weight: 600; text-align: center; border-radius: 50%;">&times;</button>
                    <p> Penal Code (1) Crimes Against a person HR (1) 01 to (1)-(16)</p>
                    <input type="text" placeholder="Assulat on a Pofficer officer" readonly>
                    <textarea placeholder=" Assault on a police officer, carries use of threats to use a weapon or imitation thereof, is found guilty of an indictable offense of 8, 000 and 90 month imprisonment. This charge is taken much more seriously than a common assault charge due to use of or threatened use of a weapon, which can cause serious bodily harm." readonly></textarea>
                    <div class="forms-records-infos">
                        <input type="number" id="manage-input-charges" placeholder="$8, 000" readonly>
                        <input type="number" id="manage-input-time" placeholder="90 moth" readonly>
                    </div>
                </div>
            </div>
        `);
    })

    $(document).on("click", ".AggravatedAssault", function () {
        $(".import-all-crime-info").fadeIn();

        $(".import-all-crime-info").html(`
            <div class="Criminal-records">
                <div class="form-records-content">
                    <button class="crime-section" style="font-size: 24px; cursor: cell; position: absolute; right: 10px; top: 5px; background: transparent; border: none; color: purple; font-weight: 600; text-align: center; border-radius: 50%;">&times;</button>
                    <p> Penal Code (1) Crimes Against a person HR (1) 01 to (1)-(16)</p>
                    <input type="text" placeholder="Aggravated Assault" readonly>
                    <textarea placeholder="TAggravated Assault, is designated as a serious offense that involves causing serious physical harm to another knowingly with the intent to commit a crime. This offense often leaves the victim, or witnesses with crippling injuries, suspects found guilty of an indictable offense of 9, 000 and 95 months imprisonment. " readonly></textarea>
                    <div class="forms-records-infos">
                        <input type="number" id="manage-input-charges" placeholder="$9, 000" readonly>
                        <input type="number" id="manage-input-time" placeholder="95 month" readonly>
                    </div>
                </div>
            </div>
        `);
    })

    $(document).on("click", ".FirstDegreeMuder", function () {
        $(".import-all-crime-info").fadeIn();

        $(".import-all-crime-info").html(`
            <div class="Criminal-records">
                <div class="form-records-content">
                    <button class="crime-section" style="font-size: 24px; cursor: cell; position: absolute; right: 10px; top: 5px; background: transparent; border: none; color: purple; font-weight: 600; text-align: center; border-radius: 50%;">&times;</button>
                    <p> Penal Code (1) Crimes Against a person HR (1) 01 to (1)-(16)</p>
                    <input type="text" placeholder="First Degree Muder" readonly>
                    <textarea placeholder="First degree murder,is designated as a serious offense that involves causing serious harm with weapon or imitation thereof, is found guilty of an indictable offense of $20, 000 and a 100 month of imprisonment." readonly></textarea>
                    <div class="forms-records-infos">
                        <input type="number" id="manage-input-charges" placeholder="$20, 000" readonly>
                        <input type="number" id="manage-input-time" placeholder="100 month -> death penelty" readonly>
                    </div>
                </div>
            </div>
        `);
    })

    $(document).on("click", ".SecondDegreeMuder", function () {
        $(".import-all-crime-info").fadeIn();

        $(".import-all-crime-info").html(`
            <div class="Criminal-records">
                <div class="form-records-content">
                    <button class="crime-section" style="font-size: 24px; cursor: cell; position: absolute; right: 10px; top: 5px; background: transparent; border: none; color: purple; font-weight: 600; text-align: center; border-radius: 50%;">&times;</button>
                    <p> Penal Code (1) Crimes Against a person HR (1) 01 to (1)-(16)</p>
                    <input type="text" placeholder="Second degree murder" readonly>
                    <textarea placeholder="Second degree murder,is designated as a serious offense that involves causing serious harm with the use of a weapon or imitation thereof, is found guilty of an indictable offense of $ 20, 000 and 90 month imprisonment. " readonly></textarea>
                    <div class="forms-records-infos">
                        <input type="number" id="manage-input-charges" placeholder="$10, 000" readonly>
                        <input type="number" id="manage-input-time" placeholder="90 month" readonly>
                    </div>
                </div>
            </div>
        `);
    })

    $(document).on("click", ".ThirdDegreeMuder", function () {
        $(".import-all-crime-info").fadeIn();

        $(".import-all-crime-info").html(`
            <div class="Criminal-records">
                <div class="form-records-content">
                    <button class="crime-section" style="font-size: 24px; cursor: cell; position: absolute; right: 10px; top: 5px; background: transparent; border: none; color: purple; font-weight: 600; text-align: center; border-radius: 50%;">&times;</button>
                    <p> Penal Code (1) Crimes Against a person HR (1) 01 to (1)-(16)</p>
                    <input type="text" placeholder="Third degree murder" readonly>
                    <textarea placeholder=" Third degree murder, carries use or the use or threatening to use a weapon or an imitation of a weapon, this causes bodily harm, choke, suffocate, or struggle the victim / witnesses,  is treated as a serious offense that involves causing serious harm with the use of a weapon or imitation thereof, is found guilty of an indictable offense of 10, 000  and 70 months imprisonment." readonly></textarea>
                    <div class="forms-records-infos">
                        <input type="number" id="manage-input-charges" placeholder="$10, 000" readonly>
                        <input type="number" id="manage-input-time" placeholder="70 month" readonly>
                    </div>
                </div>
            </div>
        `);
    })

    $(document).on("click", ".Manslaughter", function () {
        $(".import-all-crime-info").fadeIn();

        $(".import-all-crime-info").html(`
            <div class="Criminal-records">
                <div class="form-records-content">
                    <button class="crime-section" style="font-size: 24px; cursor: cell; position: absolute; right: 10px; top: 5px; background: transparent; border: none; color: purple; font-weight: 600; text-align: center; border-radius: 50%;">&times;</button>
                    <p> Penal Code (1) Crimes Against a person HR (1) 01 to (1)-(16)</p>
                    <input type="text" placeholder="Mansulater" readonly>
                    <textarea placeholder="to be added readonly"></textarea>
                    <div class="forms-records-infos">
                        <input type="number" id="manage-input-charges" placeholder="" readonly>
                        <input type="number" id="manage-input-time" placeholder="" readonly>
                    </div>
                </div>
            </div>
        `);
    })

    $(document).on("click", ".Murder", function () {
        $(".import-all-crime-info").fadeIn();

        $(".import-all-crime-info").html(`
            <div class="Criminal-records">
                <div class="form-records-content">
                    <button class="crime-section" style="font-size: 24px; cursor: cell; position: absolute; right: 10px; top: 5px; background: transparent; border: none; color: purple; font-weight: 600; text-align: center; border-radius: 50%;">&times;</button>
                    <p> Penal Code (1) Crimes Against a person HR (1) 01 to (1)-(16)</p>
                    <input type="text" placeholder="Murder" readonly>
                    <textarea placeholder="TEveryone who commits murder is guilty of an indictable offense and shall be sentenced to imprisonment for 120 months and a $8, 000 fine." readonly></textarea>
                    <div class="forms-records-infos">
                        <input type="number" id="manage-input-charges" placeholder="$8, 000" readonly>
                        <input type="number" id="manage-input-time" placeholder="120 months" readonly>
                    </div>
                </div>
            </div>
        `);
    })

    $(document).on("click", ".Kidnapping", function () {
        $(".import-all-crime-info").fadeIn();

        $(".import-all-crime-info").html(`
            <div class="Criminal-records">
                <div class="form-records-content">
                    <button class="crime-section" style="font-size: 24px; cursor: cell; position: absolute; right: 10px; top: 5px; background: transparent; border: none; color: purple; font-weight: 600; text-align: center; border-radius: 50%;">&times;</button>
                    <p> Penal Code (1) Crimes Against a person HR (1) 01 to (1)-(16)</p>
                    <input type="text" placeholder="Kidnapping" readonly>
                    <textarea placeholder=" Kidnapping and unlawful confinement carries use of tools with imitation of driving someone out of an enclosed area or locations thereof. This is treated as a serious criminal offense that involves taking people from location to location that victims are not aware of. When a suspect, suspects is found guilty of such an indictable crime the suspect is subject to $ 5, 00 & 80 month imprisonment. " readonly></textarea>
                    <div class="forms-records-infos">
                        <input type="number" id="manage-input-charges" placeholder="$5, 000" readonly>
                        <input type="number" id="manage-input-time" placeholder="80 month" readonly>
                    </div>
                </div>
            </div>
        `);
    })

    $(document).on("click", ".Torture", function () {
        $(".import-all-crime-info").fadeIn();

        $(".import-all-crime-info").html(`
            <div class="Criminal-records">
                <div class="form-records-content">
                    <button class="crime-section" style="font-size: 24px; cursor: cell; position: absolute; right: 10px; top: 5px; background: transparent; border: none; color: purple; font-weight: 600; text-align: center; border-radius: 50%;">&times;</button>
                    <p> Penal Code (1) Crimes Against a person HR (1) 01 to (1)-(16)</p>
                    <input type="text" placeholder="Torture" readonly>
                    <textarea placeholder="Torture carries use of tools with imitation of driving someone out of an enclosed area or locations thereof. This is treated as a serious criminal offense that involves taking people from location to location that victims are not aware of. When a suspect, suspects is found guilty of such an indictable crime the suspect is subject to $ 8, 00 & 80 month imprisonment. " readonly></textarea>
                    <div class="forms-records-infos">
                        <input type="number" id="manage-input-charges" placeholder="$8, 000" readonly>
                        <input type="number" id="manage-input-time" placeholder="80 month" readonly>
                    </div>
                </div>
            </div>
        `);
    })

    $(document).on("click", ".Mudilation", function () {
        $(".import-all-crime-info").fadeIn();

        $(".import-all-crime-info").html(`
            <div class="Criminal-records">
                <div class="form-records-content">
                    <button class="crime-section" style="font-size: 24px; cursor: cell; position: absolute; right: 10px; top: 5px; background: transparent; border: none; color: purple; font-weight: 600; text-align: center; border-radius: 50%;">&times;</button>
                    <p>section: Penal Code (1) Crimes Against a person HR (1) 01 to (1)-(16)</p>
                    <input type="text" placeholder="Mudilation" readonly>
                    <textarea placeholder="" readonly></textarea>
                    <div class="forms-records-infos">
                        <input type="number" id="manage-input-charges" placeholder="$9, 000" readonly>
                        <input type="number" id="manage-input-time" placeholder="90 month" readonly>
                    </div>
                </div>
            </div>
        `);
    })

    $(document).on("click", ".Failureidentify", function () {
        $(".import-all-crime-info").fadeIn();

        $(".import-all-crime-info").html(`
            <div class="Criminal-records">
                <div class="form-records-content">
                    <button class="crime-section" style="font-size: 24px; cursor: cell; position: absolute; right: 10px; top: 5px; background: transparent; border: none; color: purple; font-weight: 600; text-align: center; border-radius: 50%;">&times;</button>
                    <p>section: Penal Code (1) Crimes Against a person HR (1) 01 to (1)-(16)</p>
                    <input type="text" placeholder="Failure to identify, temporary placement" readonly>
                    <textarea placeholder="" readonly></textarea>
                    <div class="forms-records-infos">
                        <input type="number" id="manage-input-charges" placeholder="$9, 000" readonly>
                        <input type="number" id="manage-input-time" placeholder="90 month" readonly>
                    </div>
                </div>
            </div>
        `);
    })

    //  Penal Code (2) Criminal Property & Criminal Profiteering (2) 01 to (2) -13

    $(document).on("click", ".Arson", function () {
        $(".import-all-crime-info").fadeIn();

        $(".import-all-crime-info").html(`
            <div class="Criminal-records">
                <div class="form-records-content">
                    <button class="crime-section" style="font-size: 24px; cursor: cell; position: absolute; right: 10px; top: 5px; background: transparent; border: none; color: purple; font-weight: 600; text-align: center; border-radius: 50%;">&times;</button>
                    <p> Penal Code (2) Criminal Property & Criminal Profiteering (2) 01 to (2) 13 </p>
                    <input type="text" placeholder="Arson" readonly>
                    <textarea placeholder="Every person who intentionally  / recklessly causes damage by fire or explosive to any and all properties not including their personal home, is guilty of an indictable offense and liable to imprisonment for a term of (55) month and a max fine of $ $7000." readonly></textarea>
                    <div class="forms-records-infos">
                        <input type="number" id="manage-input-charges" placeholder="" readonly>
                        <input type="number" id="manage-input-time" placeholder="" readonly>
                    </div>
                </div>
            </div>
        `);
    })
    
    $(document).on("click", ".Tresspassing", function () {
        $(".import-all-crime-info").fadeIn();

        $(".import-all-crime-info").html(`
            <div class="Criminal-records">
                <div class="form-records-content">
                    <button class="crime-section" style="font-size: 24px; cursor: cell; position: absolute; right: 10px; top: 5px; background: transparent; border: none; color: purple; font-weight: 600; text-align: center; border-radius: 50%;">&times;</button>
                    <p> Penal Code (2) Criminal Property & Criminal Profiteering (2) 01 to (2) 13 </p>
                    <input type="text" placeholder="Tresspassing" readonly>
                    <textarea placeholder="Everyone without a lawful excuse or the proof of which lies on him. loiter or prowls at night on any and all property not including your own, near or at dwelling-hours suited on that property is guilty of an offense punishable on summary conviction. Warning fine of max $2000." readonly></textarea>
                    <div class="forms-records-infos">
                        <input type="number" id="manage-input-charges" placeholder="" readonly>
                        <input type="number" id="manage-input-time" placeholder="" readonly>
                    </div>
                </div>
            </div>
        `);
    }) 
    
    $(document).on("click", ".Burglary", function () {
        $(".import-all-crime-info").fadeIn();

        $(".import-all-crime-info").html(`
            <div class="Criminal-records">
                <div class="form-records-content">
                    <button class="crime-section" style="font-size: 24px; cursor: cell; position: absolute; right: 10px; top: 5px; background: transparent; border: none; color: purple; font-weight: 600; text-align: center; border-radius: 50%;">&times;</button>
                    <p> Penal Code (2) Criminal Property & Criminal Profiteering (2) 01 to (2) 13 </p>
                    <input type="text" placeholder="Burglary" readonly>
                    <textarea placeholder="Anyone without a lawful excuse entered or was in a dwelling house without the intent to commit an indictable offense, is guilty of an indictable offense with a fine of $4000 & max (60) month, in prison, for any and all offense related to burglary." readonly></textarea>
                    <div class="forms-records-infos">
                        <input type="number" id="manage-input-charges" placeholder="" readonly>
                        <input type="number" id="manage-input-time" placeholder="" readonly>
                    </div>
                </div>
            </div>
        `);
    })

    $(document).on("click", ".laarceny", function () {
        $(".import-all-crime-info").fadeIn();

        $(".import-all-crime-info").html(`
            <div class="Criminal-records">
                <div class="form-records-content">
                    <button class="crime-section" style="font-size: 24px; cursor: cell; position: absolute; right: 10px; top: 5px; background: transparent; border: none; color: purple; font-weight: 600; text-align: center; border-radius: 50%;">&times;</button>
                    <p> Penal Code (2) Criminal Property & Criminal Profiteering (2) 01 to (2) 13 </p>
                    <input type="text" placeholder="Petty laarceny" readonly>
                    <textarea placeholder="Anyone without a lawful excuse entered or was in a dwelling house without the intent to commit an indictable offense, is guilty of an indictable offense with a fine of $4000 & max (60) month, in prison, for any and all offense related to burglary." readonly></textarea>
                    <div class="forms-records-infos">
                        <input type="number" id="manage-input-charges" placeholder="" readonly>
                        <input type="number" id="manage-input-time" placeholder="" readonly>
                    </div>
                </div>
            </div>
        `);
    })

    $(document).on("click", ".Possession", function () {
        $(".import-all-crime-info").fadeIn();

        $(".import-all-crime-info").html(`
            <div class="Criminal-records">
                <div class="form-records-content">
                    <button class="crime-section" style="font-size: 24px; cursor: cell; position: absolute; right: 10px; top: 5px; background: transparent; border: none; color: purple; font-weight: 600; text-align: center; border-radius: 50%;">&times;</button>
                    <p> Penal Code (2) Criminal Property & Criminal Profiteering (2) 01 to (2) 13 </p>
                    <input type="text" placeholder="Possession of break-in-items" readonly>
                    <textarea placeholder="Everyone who, without lawful excuse, all proof of which lies on them, has in their possession any unlawful items, for the purpose of breaking into any place into any, motor, vehicle, vault or safe under circumstance that gives rise to a reasonable interface that items has been used or is intended to be used for such purpose(s) is guilt of an indictable offense and liable to imprisonment for a term not exceeding (28) month, when suspect is found guilty of an offense punishable by summary conviction. Punishment of (35) month in jail With max fine of $4000." readonly></textarea>
                    <div class="forms-records-infos">
                        <input type="number" id="manage-input-charges" placeholder="" readonly>
                        <input type="number" id="manage-input-time" placeholder="" readonly>
                    </div>
                </div>
            </div>
        `);
    })

    $(document).on("click", ".Robbery", function () {
        $(".import-all-crime-info").fadeIn();

        $(".import-all-crime-info").html(`
            <div class="Criminal-records">
                <div class="form-records-content">
                    <button class="crime-section" style="font-size: 24px; cursor: cell; position: absolute; right: 10px; top: 5px; background: transparent; border: none; color: purple; font-weight: 600; text-align: center; border-radius: 50%;">&times;</button>
                    <p> Penal Code (2) Criminal Property & Criminal Profiteering (2) 01 to (2) 13 </p>
                    <input type="text" placeholder="Robbery" readonly>
                    <textarea placeholder="The accused / suspect / government employee that commits Robbery who(s) steals, for the purpose of extorting whatever is stolen or prevents / overcome resistance to the stealing, uses violence or threats to a person or property. Steals from any person and, at the time anyone steals or immediately before or immediately thereafter, wounds, beats, strikes or uses any personal violence to that person. Assault on any personal with intent to steal from them or steals from anyone /  personals, while armed with an offensive weapon or imitation thereof. Punishment in (40) month in imprisonment  and a max fine of $ 5 000." readonly></textarea>
                    <div class="forms-records-infos">
                        <input type="number" id="manage-input-charges" placeholder="" readonly>
                        <input type="number" id="manage-input-time" placeholder="" readonly>
                    </div>
                </div>
            </div>
        `);
    })

    $(document).on("click", ".Theft", function () {
        $(".import-all-crime-info").fadeIn();

        $(".import-all-crime-info").html(`
            <div class="Criminal-records">
                <div class="form-records-content">
                    <button class="crime-section" style="font-size: 24px; cursor: cell; position: absolute; right: 10px; top: 5px; background: transparent; border: none; color: purple; font-weight: 600; text-align: center; border-radius: 50%;">&times;</button>
                    <p> Penal Code (2) Criminal Property & Criminal Profiteering (2) 01 to (2) 13 </p>
                    <input type="text" placeholder="Theft" readonly>
                    <textarea placeholder="The accused / suspect / government employee, of charges with possessions of anyone's property obtained by the commission of a crime / offense, and evidence of conviction or discharge of another person's theft of their property is admissible against the accused, and in the absence evidence to the contrary is proof that the property was stolen. Punishable imprisonment of max (50) month and $10 000 + 5000." readonly></textarea>
                    <div class="forms-records-infos">
                        <input type="number" id="manage-input-charges" placeholder="" readonly>
                        <input type="number" id="manage-input-time" placeholder="" readonly>
                    </div>
                </div>
            </div>
        `);
    })

    $(document).on("click", ".Theftover", function () {
        $(".import-all-crime-info").fadeIn();

        $(".import-all-crime-info").html(`
            <div class="Criminal-records">
                <div class="form-records-content">
                    <button class="crime-section" style="font-size: 24px; cursor: cell; position: absolute; right: 10px; top: 5px; background: transparent; border: none; color: purple; font-weight: 600; text-align: center; border-radius: 50%;">&times;</button>
                    <p> Penal Code (2) Criminal Property & Criminal Profiteering (2) 01 to (2) 13 </p>
                    <input type="text" placeholder="Teft over $500" readonly>
                    <textarea placeholder="The accused / suspect / government employee, of this charge with possession of any other property that does not belong to the or obtained by the commission of any offense, evidence of the conviction or discharge of another person or thief of the property is admissible  against the accused, and the absence of evidence to the contrary is proof that property was stolen. This includes and is not limited to (motors, vehicle, air plane). Punishable with a max jail time of (55) month & $5 000." readonly></textarea>
                    <div class="forms-records-infos">
                        <input type="number" id="manage-input-charges" placeholder="" readonly>
                        <input type="number" id="manage-input-time" placeholder="" readonly>
                    </div>
                </div>
            </div>
        `);
    })

    $(document).on("click", ".Extortion", function () {
        $(".import-all-crime-info").fadeIn();

        $(".import-all-crime-info").html(`
            <div class="Criminal-records">
                <div class="form-records-content">
                    <button class="crime-section" style="font-size: 24px; cursor: cell; position: absolute; right: 10px; top: 5px; background: transparent; border: none; color: purple; font-weight: 600; text-align: center; border-radius: 50%;">&times;</button>
                    <p> Penal Code (2) Criminal Property & Criminal Profiteering (2) 01 to (2) 13 </p>
                    <input type="text" placeholder="Extortion" readonly>
                    <textarea placeholder="The accused / suspect / government employee,  who commits extortions including government officials and governments himself will be charged with extortion of the first degree. The accused / suspect / government is restricted  from using firearms whether or not commiting / committed any servite crime. The offense is committed on the benefit of, at direction of, or in association with any server crime organization, to imprisonment for life and a minimum punishment of imprisonment of  a term, incase of the first offense will receive (70) month in prison and the second case of the subsequent offense, will be (50) month any other case where firearm is used in the commission of any and all offense the accused / suspect / government  will receive the max (Four trem) if more cases comes from this that same accused / suspect / government  will receive the max punishment of life in prison." readonly></textarea>
                    <div class="forms-records-infos">
                        <input type="number" id="manage-input-charges" placeholder="" readonly>
                        <input type="number" id="manage-input-time" placeholder="" readonly>
                    </div>
                </div>
            </div>
        `);
    })

    $(document).on("click", ".Forgery", function () {
        $(".import-all-crime-info").fadeIn();

        $(".import-all-crime-info").html(`
            <div class="Criminal-records">
                <div class="form-records-content">
                    <button class="crime-section" style="font-size: 24px; cursor: cell; position: absolute; right: 10px; top: 5px; background: transparent; border: none; color: purple; font-weight: 600; text-align: center; border-radius: 50%;">&times;</button>
                    <p> Penal Code (2) Criminal Property & Criminal Profiteering (2) 01 to (2) 13 </p>
                    <input type="text" placeholder="Fortgery" readonly>
                    <textarea placeholder="The accused / suspect / government employee who commits forgery and false documents, knowing it will be unseeable in the court of law or in any way not acting on a genuine, to the prejudice of any weather in San Andreas / Los Santos or not. That person will be induced, by the belief that is genuine, to do or refrain from doing anything, in San Andreas / Los Santos. Making false documents in any material part. Making a false document includes altering genuine documents in any material part or making a material genuine document while still adding any false information / stealing other information for any false documents.  In addition making a material or alternation in a genuine document by ensuing, obliteration, removal or in any way. When any forgery is complete. Forgery is the knowledge and intent referred to to subsection (1) notwithstanding that the person who makes it does not intend that in any particular person should used or act on it as a genuine or be induced by the belief that it is genuine , doing this refrain that suspect / government from doing anything. Fogery complet through document whether incomplete or not. Forgery is complete notwithstanding that the false document is incomplete or does noy purport to be a document that is binding in law, if such as to indicate that it was intended to be acted on as genuine. No exception: No person commits forgery by reason only that person, in good faith, makes a false document at the request of any and all police officers/ force in San Andreas / Los Santos forces or any department or agency of the federal government or of a provincial government. Marsal can and will arrest any officer in law who swore an oath to the legion, if illegally found committing this crime / Pending an IA for you to be 10-93. Punishable imprisonment of max time (100) by indictable offense and fine of up to $5 000  - 10 000." readonly></textarea>
                    <div class="forms-records-infos">
                        <input type="number" id="manage-input-charges" placeholder="" readonly>
                        <input type="number" id="manage-input-time" placeholder="" readonly>
                    </div>
                </div>
            </div>
        `);
    })

    $(document).on("click", ".Fraud", function () {
        $(".import-all-crime-info").fadeIn();

        $(".import-all-crime-info").html(`
            <div class="Criminal-records">
                <div class="form-records-content">
                    <button class="crime-section" style="font-size: 24px; cursor: cell; position: absolute; right: 10px; top: 5px; background: transparent; border: none; color: purple; font-weight: 600; text-align: center; border-radius: 50%;">&times;</button>
                    <p> Penal Code (2) Criminal Property & Criminal Profiteering (2) 01 to (2) 13 </p>
                    <input type="text" placeholder="Fraud" readonly>
                    <textarea placeholder="The accused / suspect / government(employees)  who commits such a heinous crime  of deceit, falsehood or other fraudulent means, weather or it is false pretense with in the meaning of this Act, defrauds the public or any person, weather ascertained or not any property, money or valuable security  or any service is guilty if an indictable offense and is liable to a (1) term of imprisonment not exceeding the time given, where the subject matter of this offense is a testamentary instrument or the value of the subject -matter of the offense exceeding $5 000. Imprisonment of max time (100) month." readonly></textarea>
                    <div class="forms-records-infos">
                        <input type="number" id="manage-input-charges" placeholder="" readonly>
                        <input type="number" id="manage-input-time" placeholder="" readonly>
                    </div>
                </div>
            </div>
        `);
    })

    $(document).on("click", ".Mischief", function () {
        $(".import-all-crime-info").fadeIn();

        $(".import-all-crime-info").html(`
            <div class="Criminal-records">
                <div class="form-records-content">
                    <button class="crime-section" style="font-size: 24px; cursor: cell; position: absolute; right: 10px; top: 5px; background: transparent; border: none; color: purple; font-weight: 600; text-align: center; border-radius: 50%;">&times;</button>
                    <p> Penal Code (2) Criminal Property & Criminal Profiteering (2) 01 to (2) 13 </p>
                    <input type="text" placeholder="Mischief" readonly>
                    <textarea placeholder="The accused / suspect / government(employees) commits mischief willfully/ destroy or Damage any and all property. Renders property dangerous, unless, inoperative or ineffective. Obstruction, interrupts or interferes with the lawful use, enjoyment or operation of property. The accused / suspect / government(employees) that cause actual Damage to life is guilty of an indictable offense and is liable to imprisonment for life. The Maximum fine of this offense is $10 000.  And time of (70-100) months." readonly></textarea>
                    <div class="forms-records-infos">
                        <input type="number" id="manage-input-charges" placeholder="" readonly>
                        <input type="number" id="manage-input-time" placeholder="" readonly>
                    </div>
                </div>
            </div>
        `);
    })
    
    // Penal Code (3) Public endangerment (3) 01 - (3) - 5
    $(document).on("click", ".Intoxication", function () {
        $(".import-all-crime-info").fadeIn();

        $(".import-all-crime-info").html(`
            <div class="Criminal-records">
                <div class="form-records-content">
                    <button class="crime-section" style="font-size: 24px; cursor: cell; position: absolute; right: 10px; top: 5px; background: transparent; border: none; color: purple; font-weight: 600; text-align: center; border-radius: 50%;">&times;</button>
                    <Penal Code (3) Public endangerment (3) 01 - (3) - 5></p>
                    <input type="text" placeholder=" Public intoxication" readonly>
                    <textarea placeholder="" readonly></textarea>
                    <div class="forms-records-infos">
                        <input type="number" id="manage-input-charges" placeholder="" readonly>
                        <input type="number" id="manage-input-time" placeholder="" readonly>
                    </div>
                </div>
            </div>
        `);
    })

    $(document).on("click", ".ControlledSubstance", function () {
        $(".import-all-crime-info").fadeIn();

        $(".import-all-crime-info").html(`
            <div class="Criminal-records">
                <div class="form-records-content">
                    <button class="crime-section" style="font-size: 24px; cursor: cell; position: absolute; right: 10px; top: 5px; background: transparent; border: none; color: purple; font-weight: 600; text-align: center; border-radius: 50%;">&times;</button>
                    <Penal Code (3) Public endangerment (3) 01 - (3) - 5></p>
                    <input type="text" placeholder="" readonly>
                    <textarea placeholder="" readonly></textarea>
                    <div class="forms-records-infos">
                        <input type="number" id="manage-input-charges" placeholder="" readonly>
                        <input type="number" id="manage-input-time" placeholder="" readonly>
                    </div>
                </div>
            </div>
        `);
    })

    $(document).on("click", ".Opencontainer", function () {
        $(".import-all-crime-info").fadeIn();

        $(".import-all-crime-info").html(`
            <div class="Criminal-records">
                <div class="form-records-content">
                    <button class="crime-section" style="font-size: 24px; cursor: cell; position: absolute; right: 10px; top: 5px; background: transparent; border: none; color: purple; font-weight: 600; text-align: center; border-radius: 50%;">&times;</button>
                    <Penal Code (3) Public endangerment (3) 01 - (3) - 5></p>
                    <input type="text" placeholder="" readonly>
                    <textarea placeholder="" readonly></textarea>
                    <div class="forms-records-infos">
                        <input type="number" id="manage-input-charges" placeholder="" readonly>
                        <input type="number" id="manage-input-time" placeholder="" readonly>
                    </div>
                </div>
            </div>
        `);
    })

    $(document).on("click", ".Incidences", function () {
        $(".import-all-crime-info").fadeIn();

        $(".import-all-crime-info").html(`
            <div class="Criminal-records">
                <div class="form-records-content">
                    <button class="crime-section" style="font-size: 24px; cursor: cell; position: absolute; right: 10px; top: 5px; background: transparent; border: none; color: purple; font-weight: 600; text-align: center; border-radius: 50%;">&times;</button>
                    <Penal Code (3) Public endangerment (3) 01 - (3) - 5></p>
                    <input type="text" placeholder="" readonly>
                    <textarea placeholder="" readonly></textarea>
                    <div class="forms-records-infos">
                        <input type="number" id="manage-input-charges" placeholder="" readonly>
                        <input type="number" id="manage-input-time" placeholder="" readonly>
                    </div>
                </div>
            </div>
        `);
    });

    $(document).on("click", ".Publicendangerment", function () {
        $(".import-all-crime-info").fadeIn();

        $(".import-all-crime-info").html(`
            <div class="Criminal-records">
                <div class="form-records-content">
                    <button class="crime-section" style="font-size: 24px; cursor: cell; position: absolute; right: 10px; top: 5px; background: transparent; border: none; color: purple; font-weight: 600; text-align: center; border-radius: 50%;">&times;</button>
                    <Penal Code (3) Public endangerment (3) 01 - (3) - 5></p>
                    <input type="text" placeholder="" readonly>
                    <textarea placeholder="" readonly></textarea>
                    <div class="forms-records-infos">
                        <input type="number" id="manage-input-charges" placeholder="" readonly>
                        <input type="number" id="manage-input-time" placeholder="" readonly>
                    </div>
                </div>
            </div>
        `);
    });

    //Penal Code (4) Criminal Against Public Justice (4)  01 to (4) 21

    $(document).on("click", ".Bribery", function () {
        $(".import-all-crime-info").fadeIn();

        $(".import-all-crime-info").html(`
            <div class="Criminal-records">
                <div class="form-records-content">
                    <button class="crime-section" style="font-size: 24px; cursor: cell; position: absolute; right: 10px; top: 5px; background: transparent; border: none; color: purple; font-weight: 600; text-align: center; border-radius: 50%;">&times;</button>
                    <input type="text" placeholder="Bribery" readonly>
                    <textarea placeholder="The accused / suspect / government(employees) commits bribery are all guilty of indictable offense and liable to imprisonment of on term not exceeding fourteen years if or who bing hold for judicial offense, or being a members of parliament or of the legislature of a city, directly or indirectly, corruptly accepts obtain, agree to accept or attempts to obtain for themselves or another person's with or within money, valuables consideration, office, that benefits from that accused / suspect / government(employees). Law directly or indirectly, corrupt accepts, obtain, agrees to accept to obtain for themselves or another person, any money valuables, consideration, office, place of employment with intent to interfere with administration of justice, to procure of facilitate the commission of office or to protect from detection or punishment a person who has committed the commission of an offense or to protect from detection or punishment a person who committed or who intends to commit an offense or direct or indirectly, corrupt gives or offer to any and all persons mentioned. Punishment of (80-100) month and fine up to $5000." readonly></textarea>
                    <div class="forms-records-infos">
                        <input type="number" id="manage-input-charges" placeholder="" readonly>
                        <input type="number" id="manage-input-time" placeholder="" readonly>
                    </div>
                </div>
            </div>
        `);
    })

    $(document).on("click", ".Payfine", function () {
        $(".import-all-crime-info").fadeIn();

        $(".import-all-crime-info").html(`
            <div class="Criminal-records">
                <div class="form-records-content">
                    <button class="crime-section" style="font-size: 24px; cursor: cell; position: absolute; right: 10px; top: 5px; background: transparent; border: none; color: purple; font-weight: 600; text-align: center; border-radius: 50%;">&times;</button>
                    <input type="text" placeholder="Failure to pay fine" readonly>
                    <textarea placeholder="The accused / suspect will receive a $5 000 in fine for failure to pay for any and all fines. Max imprisonment of (70) month Read notes section above." readonly></textarea>
                    <div class="forms-records-infos">
                        <input type="number" id="manage-input-charges" placeholder="" readonly>
                        <input type="number" id="manage-input-time" placeholder="" readonly>
                    </div>
                </div>
            </div>
        `);
    })

    $(document).on("click", ".Contempt", function () {
        $(".import-all-crime-info").fadeIn();

        $(".import-all-crime-info").html(`
            <div class="Criminal-records">
                <div class="form-records-content">
                    <button class="crime-section" style="font-size: 24px; cursor: cell; position: absolute; right: 10px; top: 5px; background: transparent; border: none; color: purple; font-weight: 600; text-align: center; border-radius: 50%;">&times;</button>
                    <input type="text" placeholder="Contempt" readonly>
                    <textarea placeholder="The accused / suspect / government(employees) required by law to attend or remain in attendance for the purpose of giving evidence, fails, without lawful excuse  to attend or remain in attendance accordingly is guilty of contempt of court. Punishment. In a court, judge, justice, provincial court or police officer may deal summarily with a person who is guilty of contempt of court under section and The accused / suspect / government(employees) is liable to a fine not exceeding 1, 000, 000 and a  imprisonment (50) for a whole term not that one term, they will be asked to pay a fine cost of an indictable to the service of any process under oath." readonly></textarea>
                    <div class="forms-records-infos">
                        <input type="number" id="manage-input-charges" placeholder="" readonly>
                        <input type="number" id="manage-input-time" placeholder="" readonly>
                    </div>
                </div>
            </div>
        `);
    })

    $(document).on("click", ".Subpoena", function () {
        $(".import-all-crime-info").fadeIn();

        $(".import-all-crime-info").html(`
            <div class="Criminal-records">
                <div class="form-records-content">
                    <button class="crime-section" style="font-size: 24px; cursor: cell; position: absolute; right: 10px; top: 5px; background: transparent; border: none; color: purple; font-weight: 600; text-align: center; border-radius: 50%;">&times;</button>
                    <input type="text" placeholder="Subpoena violation" readonly>
                    <textarea placeholder="To be added" readonly></textarea>
                    <div class="forms-records-infos">
                        <input type="number" id="manage-input-charges" placeholder="" readonly>
                        <input type="number" id="manage-input-time" placeholder="" readonly>
                    </div>
                </div>
            </div>
        `);
    })

    $(document).on("click", ".Obstruction", function () {
        $(".import-all-crime-info").fadeIn();

        $(".import-all-crime-info").html(`
            <div class="Criminal-records">
                <div class="form-records-content">
                    <button class="crime-section" style="font-size: 24px; cursor: cell; position: absolute; right: 10px; top: 5px; background: transparent; border: none; color: purple; font-weight: 600; text-align: center; border-radius: 50%;">&times;</button>
                    <input type="text" placeholder="Obstruction" readonly>
                    <textarea placeholder="The accused / suspect willfully attempts in any manner to obstruct, prevent or defeat the course of justice in a judicial proceeding, by indemnifying or, by indemnifying or agreeing to indemnify a surety, in any way and either in whole or in part where his is a surety by accepting or agreeing to accept fee or any form of indemnity  weather in while or in part from or in respect of a person who is released or is to be released from custody, is guilty of an indictable offense and is liable to imprisonment for a term and max jail time of (70) months & fine of $5000, while not exceeding the normal time set for the rest of the law. " readonly></textarea>
                    <div class="forms-records-infos">
                        <input type="number" id="manage-input-charges" placeholder="" readonly>
                        <input type="number" id="manage-input-time" placeholder="" readonly>
                    </div>
                </div>
            </div>
        `);
    })

    $(document).on("click", ".harvesting", function () {
        $(".import-all-crime-info").fadeIn();

        $(".import-all-crime-info").html(`
            <div class="Criminal-records">
                <div class="form-records-content">
                    <button class="crime-section" style="font-size: 24px; cursor: cell; position: absolute; right: 10px; top: 5px; background: transparent; border: none; color: purple; font-weight: 600; text-align: center; border-radius: 50%;">&times;</button>
                    <input type="text" placeholder="" readonly>
                    <textarea placeholder="" readonly></textarea>
                    <div class="forms-records-infos">
                        <input type="number" id="manage-input-charges" placeholder="" readonly>
                        <input type="number" id="manage-input-time" placeholder="" readonly>
                    </div>
                </div>
            </div>
        `);
    })
    
//     $(document).on("click", " ", function () {
//         $(".import-all-crime-info").fadeIn();

//         $(".import-all-crime-info").html(`
//             <div class="Criminal-records">
//                 <div class="form-records-content">
//                     <button class="crime-section" style="font-size: 24px; cursor: cell; position: absolute; right: 10px; top: 5px; background: transparent; border: none; color: purple; font-weight: 600; text-align: center; border-radius: 50%;">&times;</button>
//                     <input type="text" placeholder="" readonly>
//                     <textarea placeholder="" readonly></textarea>
//                     <div class="forms-records-infos">
//                         <input type="number" id="manage-input-charges" placeholder="" readonly>
//                         <input type="number" id="manage-input-time" placeholder="" readonly>
//                     </div>
//                 </div>
//             </div>
//         `);
//     })

//     $(document).on("click", " ", function () {
//         $(".import-all-crime-info").fadeIn();

//         $(".import-all-crime-info").html(`
//             <div class="Criminal-records">
//                 <div class="form-records-content">
//                     <button class="crime-section" style="font-size: 24px; cursor: cell; position: absolute; right: 10px; top: 5px; background: transparent; border: none; color: purple; font-weight: 600; text-align: center; border-radius: 50%;">&times;</button>
//                     <input type="text" placeholder="" readonly>
//                     <textarea placeholder="" readonly></textarea>
//                     <div class="forms-records-infos">
//                         <input type="number" id="manage-input-charges" placeholder="" readonly>
//                         <input type="number" id="manage-input-time" placeholder="" readonly>
//                     </div>
//                 </div>
//             </div>
//         `);
//     })
})