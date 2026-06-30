// // Code that steaches both name and plate search

// // Optimized performSearch function
// function performSearch(searchTerm, data) { 
//     if(!searchTerm) return false;
//     searchTerm = searchTerm.toLowerCase();
//     return data.some(item => 
//     (item.firstname.toLowerCase().includes(searchTerm) || 
//     item.CSN.toLowerCase().includes(searchTerm)));
// }

// // Simplified checkEnter function with optimized search logic
// function checkEnter (event, data) {
//     if(event.key !== "Enter" && event.keyCode !== 13) return;

//     const inputfield = $(".search-button, #manage-civilian-input, #manage-crime-input");
//     const searchTerm = inputfield.val().trim();

//     if (!checkSearchInput(searchTerm)) {
//         $(".No-data").text("Please enter a valid search term.");
//     }

//     const searchresult = performSearch(searchTerm, data);

//     if (!searchresult) {
//         $(".No-data").text("No data found for " + searchTerm);
//     } else {
//         $("#searchlist", ".recent-searches").append( `<p style="width:90%; background:#555; display:flex; padding: 0 20px; justify-content:space-between;">
//             ${searchTerm} <i style="margin-left:5px;" class="search-button fas fa-random"></i>
//         </p>`);
//     }
// };

// // #Searchlist, #Recentnames, #recent-searches
