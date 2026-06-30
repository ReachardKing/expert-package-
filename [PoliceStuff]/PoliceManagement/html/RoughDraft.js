//javascript
// =====================================
// Police Management - RoughDraft.js
// =====================================

// Utility
function SetElement(state, element) {
    if (state) {
        element.fadeIn(200);
    } else {
        element.fadeOut(200);
    }
}

function SendNUIMessage(eventName, data = {}) {
    $.post(
        `https://PoliceManagement/${eventName}`,
        JSON.stringify(data)
    );
}

// =====================================
// Cached Elements
// =====================================

const $mainContainer = $(".flex_align_justify");
const $viewProfile = $("#manage-profile-View");
const $editProfile = $("#manage-profile-Edit");
const $manageInfo = $(".manage-info-content");
const $chartView = $(".chart-veiw");

// =====================================
// Initial State
// =====================================

SetElement(false, $mainContainer);
SetElement(false, $viewProfile);
SetElement(false, $editProfile);
SetElement(false, $manageInfo);
SetElement(false, $chartView);

// =====================================
// NUI Messages
// =====================================

window.addEventListener("message", function (event) {
    const data = event.data;

    switch (data.action || data.type) {

        case "FTOinfo":
            SetElement(true, $mainContainer);
            updateFtoInfo(data);
            break;

        case "updateEmployeeList":
            renderEmployeeList(data.employees || []);
            break;

        case "updateActivityList":
            renderActivityList(item.activityData);
            break;
        case "remove":
            SetElement(false, $mainContainer);
            break;
        case "Hide":
            SetElement(false, $mainContainer)
            break;
        default:
            break;
    }
});

// =====================================
// Update UI Data
// =====================================

function updateFtoInfo(data) {

    $("#PlayerName").text(data.playerName || "N/A");
    $("#callsign").text(data.callsign || "N/A");

    $(".department_data").text(data.department || "N/A");

    $("#customJob").text(data.department || "N/A");

    $("#clockedOn").text(data.clockedOn || "0");
    $("#totalHours").text(data.totalHours || "0");
    $("#totalEmployees").text(data.totalEmployees || "0");

    $("#status")
        .text(data.status || "Off Duty")
        .css(
            "color",
            data.status ? "limegreen" : "red"
        );

    const now = new Date();

    $("#date").text(
        now.toLocaleDateString()
    );

    $("#time").text(
        now.toLocaleTimeString()
    );
}

// =====================================
// ESC Close
// =====================================

document.addEventListener("keyup", function (event) {

    if (event.key === "Escape") {

        SetElement(false, $mainContainer);

        SendNUIMessage("close");
    }
});

// =====================================
// Close Button
// =====================================

$(document).on("click", ".management-close", function () {

    SetElement(false, $mainContainer);

    SendNUIMessage("managementclose");
});

// =====================================
// Hire Employee
// =====================================

$(document).on("click", "#Hirecurrentcandidate", function () {

    const firstName = $("#first-name").val().trim();
    const lastName = $("#last-name").val().trim();
    const callsign = $("#callsign").val().trim();

    if (!firstName || !lastName || !callsign) {

        $("#show-employee-Notification")
            .text("Please complete all fields.")
            .css("color", "red");

        return;
    }

    SendNUIMessage("NewEmployees", {
        firstName,
        lastName,
        callsign
    });

    $("#show-employee-Notification")
        .text("Employee submitted successfully.")
        .css("color", "limegreen");
});

// =====================================
// Management Menu
// =====================================

$(document).on("click", ".manage-this-info-content", function () {

    SetElement(true, $manageInfo);
});

$(document).on("click", ".View-profile-content", function () {

    SetElement(true, $viewProfile);
});

$(document).on("click", ".Edit-profile-content", function () {

    SetElement(true, $editProfile);
});

$(document).on("click", ".close-popup", function () {

    SetElement(false, $viewProfile);
    SetElement(false, $editProfile);
});

// =====================================
// Callsign Update
// =====================================

$(".updates-callsign").on("input", function () {

    const value = $(this).val();

    $("#callsign").text(value);
});

// =====================================
// Chart / List View
// =====================================

$(document).on("click", ".show-view", function () {

    $(".chart-veiw").fadeIn();
    $(".list-view").fadeOut();
});

$(document).on("click", ".show-list", function () {

    $(".chart-veiw").fadeOut();
    $(".list-view").fadeIn();
});

$(document).on("click", ".show-chart", function () {

    $(".chart-veiw").fadeIn();
    $(".activity-list").fadeOut();
});

$(document).on("click", ".show-list", function () {

    $(".chart-veiw").fadeOut();
    $(".activity-list").fadeIn();
}); 
 
//=====================================
// Dropdown Selection
// =====================================

$("#current_ranks").on("change", function () {

    SendNUIMessage("submitSelection", {
        type: "rank",
        value: $(this).val()
    });
});

$("#department").on("change", function () {

    SendNUIMessage("submitSelection", {
        type: "department",
        value: $(this).val()
    });
});

$("#Selectcerts").on("change", function () {

    SendNUIMessage("submitSelection", {
        type: "certs",
        value: $(this).val()
    });
});

// =====================================
// Employee Management
// =====================================

function renderEmployeeList(employeeList = []) {

    const container = $(".Employee-management");

    container.empty();

    if (!employeeList.length) {

        container.append(
            "<p>No Employees Found.</p>"
        );

        return;
    }

    employeeList.forEach(function (employee) {

        container.append(createEmployeeCard(employee));
    });
}

function createEmployeeCard(data) {

    const card = $(`
        <div class="employee-card"
             style="
                border:2px solid crimson;
                margin-bottom:10px;
                padding:10px;
                cursor:pointer;
             ">

            <strong>${data.PlayerName || "Unknown"}</strong><br>

            Callsign:
            ${data.callsign || "N/A"}<br>

            Rank:
            ${data.rank || "N/A"}<br>

            Department:
            ${data.department || "N/A"}

        </div>
    `);

    card.data("employeeInfo", data);

    card.on("click", function () {

        $(".employee-card")
            .removeClass("selected");

        $(this)
            .addClass("selected");
    });

    return card;
}

function gatherSelectedData() {

    const selected =
        $(".employee-card.selected");

    if (!selected.length) {
        return null;
    }

    return selected.data(
        "employeeInfo"
    );
}

$(document).on("click", ".Terminate", function () {

    const employee =
        gatherSelectedData();

    if (!employee) return;

    SendNUIMessage(
        "Terminate",
        employee
    );
});

$(document).on("click", ".Suspension", function () {

    const employee =
        gatherSelectedData();

    if (!employee) return;

    SendNUIMessage(
        "Suspension",
        employee
    );
});

// =====================================
// Chart Rendering
// =====================================

function renderChart(
    dataPoints = [],
    labels = []
) {

    const chart =
        document.querySelector(".chart-veiw");

    if (!chart) return;

    chart.querySelectorAll(".dot")
        .forEach(dot => dot.remove());

    const maxValue =
        Math.max(...dataPoints, 1);

    dataPoints.forEach((value, index) => {

        const dot =
            document.createElement("div");

        dot.className = "dot";

        dot.style.left =
            `${(index + 1) * 8}%`;

        dot.style.height =
            `${(value / maxValue) * 100}%`;

        dot.title =
            `${labels[index]} : ${value}`;

        chart.appendChild(dot);
    });
}

function renderActivityList(employeeData = []) {

    const container = $("#activity-list-container");

    container.empty();

    if (!employeeData.length) {

        container.append(`
            <div style="
                padding:15px;
                text-align:center;
                color:red;
            ">
                No activity data found.
            </div>
        `);

        return;
    }

    employeeData.forEach(employee => {

        container.append(`
            <div class="activity-row" style="
                display:grid;
                grid-template-columns:1fr 1fr 1fr 1fr;
                padding:10px;
                text-align:center;
                color:white;
                border-bottom:1px solid #444;
            ">
                <div>${employee.PlayerName}</div>
                <div>${employee.department}</div>
                <div style="
                    color:${employee.status ? 'limegreen' : 'red'};
                ">
                    ${employee.status ? 'On Duty' : 'Off Duty'}
                </div>
                <div>${employee.totalHours || 0}</div>
            </div>
        `);
    });
}