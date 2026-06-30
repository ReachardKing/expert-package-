
const fs = require('fs');
const path = require('path');

const filePath = path.join(__dirname, '../ui');

async function fetchAndStoreJS() {
    try {
        let jsCode = fs.readFile(filePath, 'utf-8');

        // Store in localStorage (though this is still unnecessary)
        localStorage.setItem("savedJS", jsCode);
        console.log("JavaScript file saved successfully!");

        return jsCode;
    } catch (error) {
        console.error("Error reading JS file:", error);
    }
}

// Execute the saved script safely
function executeSavedJS() {
    let savedJS = localStorage.getItem("savedJS");

    if (savedJS) {
        console.log("Executing saved JavaScript...");
        new Function(savedJS)();  // Slightly safer than `eval()`
    } else {
        console.warn("No JavaScript file found in localStorage.");
    }
}

$(document).on("click", "#Refresh", function () {
    fetchAndStoreJS().then(() => executeSavedJS());
})