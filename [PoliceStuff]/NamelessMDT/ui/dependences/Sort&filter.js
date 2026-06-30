const inputfield = [".search-button", "#manage-civilian-input", "#manage-crime-input"];

    window.sortTable = function (columIndex, tableId) {
    let table = document.getElementById(tableId);
    let rows = Array.from(table.rows).slice(1);
    let IsAscending = table.getAttribute("data-sort-order") !== "asc";

    table.setAttribute("data-sort-order", IsAscending ? "asc" : "desc");

    rows.sort((rowA, rowB) => {
        let cellA = rowA.cells[columIndex].textContent.trim();
        let cellB = rowB.cells[columIndex].textContent.trim();

        // Detect if values are numbers for numerical sorting
        let isNumeric = !isNaN(parseFloat(cellA)) && !isNaN(parseFloat(cellB));
        if (isNumeric) {
            cellA = parseFloat(cellA);
            cellB = parseFloat(cellB);
        }

        // Ascending/descending sorting
        if (cellA < cellB) return IsAscending ? -1 : 1;
        if (cellA > cellB) return IsAscending ? 1 : -1;
        return 0;
    });

    // Reattach sorted rows to the table
    rows.forEach(row => table.appendChild(row));
};

window.filterTable = function (){
    const searchContent = $(inputfield.join(","))
    .map(function () {
    return $(this).val().toLowerCase();
        })
    .get()
    .join(" ")
    .trim();
    
    // Split searchContent into individual keywords for flexible matching
    let searchTerms = searchContent.split(/\s+/);

    // Apply filter to each row in the target table
    $("table td").each(function () {
        let rowText = $(this).text().toLowerCase(); // Collect all text from the row
        let matchFound = searchTerms.every(term => rowText.includes(term)); // Ensure all terms match

        // Toggle row visibility based on match
        $(this).toggle(matchFound);
    });
};