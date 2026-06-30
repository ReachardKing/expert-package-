
// $(document).ready(function () {
//     $(function () {
//         function Display(bool) {
//             if (bool) {
//                 $("#PoliceContainer").show();
//             } else {
//                 $("#PoliceContainer").hide();
//             }
//         }

//         Display(true)


//         $("#custominput").append(`
//             <span class="minus">-</span>
//             <span class="num">0</span>
//             <span class="plus">+</span>
//         `);

//         window.addEventListener("message", (event) => {
//             var item = event.data;

//             if (item !== undefined && item.type === "init") {
//                 if (item.visible == true) {
//                     Display(true)
//                 } else {
//                     Display(false)
//                 }
//             }

//             if (item.visible == false) {
//                 $("#Container").hide();
//             }

//             if (item.type === "remove") {
//                 $("#Container").hide();
//             }

//             $(".impound-submit").submit(function (e) {
//                 e.preventDefault();
//             });

//             $(".impound-cancel").click(function (e) {
//                 e.preventDefault();

//             });

//             $(".Close-impound").click(function () {
//                 $.post("https://PoliceImpound/cancel", JSON.stringify({}))
//             })

//             $(".impound-cancel").click(function () {
//                 $.post("https://PoliceImpound/cancel", JSON.stringify({}))

//             });

//             $(".impound-submit").click(function () {
//                 $.post("https://PoliceImpound/submit", JSON.stringify({}))

//             });

//             $(".impound-cancel").click(function () {
//                 $.post("https://PoliceImpound/cancel", JSON.stringify({}))

//             });

//             $(".impound-submit").click(function () {
//                 $.post("https://PoliceImpound/submit", JSON.stringify({}))
//             });
//         })
//     })

//     $(() => {
//         $(".impound-submit").click(() => {
//             const plate = $(".impound-plate").val();
//             const linkedreport = $(".impound-inkedreport").val();
//             const fee = $(".impound-fee").val();
//             const time = $(".impound-time").val();
//             const reason = $(".r-reason").val();
//             const Selection = $(".SelectImpound").val()

//             if (!plate || plate === "") {
//                 $(".ImpoundContainer").css("border", "1px solid rgb(184, 3, 3)");
//                 setTimeout(() => {
//                     $(".ImpoundContainer").css("border", "1px solid rgb(168, 168, 168)");
//                 }, 500);
//                 return;
//             }

//             if (!linkedreport || linkedreport == "") {
//                 $(".ImpoundContainer").css("bolder", "1px solid rgb(184, 3, 3");
//                 setTimeout(() => {
//                     $("ImpoundContainer").css("bolder", "1px solid rgba(184, 3,3");
//                 }, 5000);
//                 return;
//             }
//             if (!fee || fee === "") {
//                 $(".ImpoundContainer").css("bolder", "1px solid rgb(184, 3, 3");
//                 setTimeout(() => {
//                     $("ImpoundContainer").css("bolder", "1px solid rgba(184, 3,3");
//                 }, 5000);
//                 return;
//             }
//             if (!time || time == "") {
//                 $(".ImpoundContainer").css("bolder", "1px solid rgb(184, 3, 3");
//                 setTimeout(() => {
//                     $("ImpoundContainer").css("bolder", "1px solid rgba(184, 3,3");
//                 }, 5000);
//                 return;
//             }
//             if (!reason || reason === "") {
//                 $(".ImpoundContainer").css("bolder", "1px solid rgb(184, 3, 3");
//                 setTimeout(() => {
//                     $("ImpoundContainer").css("bolder", "1px solid rgba(184, 3,3");
//                 }, 5000);
//                 return;
//             }

//             if (!Selection || Selection == "") {
//                 $(".SelectImpound").css("bolder", "1px sold rgba(184, 3, 3")
//                 setTimeout(() => {
//                     $(".SelectImpound").css("bolder", "1px sold rgba(184, 3, 3")
//                 }, 5000);
//                 return
//             }

//             $.post(`https://PoliceImpound/impomdVehicle`, JSON.stringify({
//                 plate: plate,
//                 linkedreport: linkedreport,
//                 fee: fee,
//                 time: time,
//                 reason: reason,
//                 Selection: Selection
//             }))
           
//         })

//         $(".impound-cancel").click(() => {
//             const plate = $(".impound-plate").val();
//             $.post(`https://PoliceImpound/removeImpound`, JSON.stringify({ plate: plate }))
//         })

//         $(".Close-impound").click(() => {
//             $(".ImpoundContainer").slideUp(250);
//             $(".ImpoundContainer").fadeOut(250);
//         })
        
//         $(".impound-cancel").click(() => {
//             $(".ImpoundContainer").slideUp(250);
//             $(".ImpoundContainer").fadeOut(250);

//             $(".impound-plate").val();
//             $(".impound-inkedreport").val();
//             $("#impound-seze-range").val()
//             $(".impound-fee").val();
//             $(".impound-time").val();
//             $(".r-reason").val();
//             $(".SelectImpound").val()
//         })

//         $(".impound-submit").click(() => {
//             $(".ImpoundContainer").slideUp(250);
//             $(".ImpoundContainer").fadeOut(250);

//             $(".impound-plate").val();
//             $(".impound-inkedreport").val();
//             $("#impound-seze-range").val()
//             $(".impound-fee").val();
//             $(".impound-time").val();
//             $(".r-reason").val();
//             $(".SelectImpound").val()
//         })
//     })
// })

function displayPoliceContainer(show) {
	$(".ImpoundContainer").toggle(show);
}

displayPoliceContainer(false);

$("#custominput").html(`
	<span class="minus">-</span>
	<span class="num">0</span>
	<span class="plus">+</span>
`);

// Cache frequently used jQuery selectors
const $impoundContainer = $(".ImpoundContainer");
const $selectionInput = $(".SelectImpound");
const $Impoundfee = $(".impound-fee");

// Handle plus button click
$(document).on('click', '.plus', function () {
	var currentFee = parseInt($('.num').text()); // Get current fee
	var newFee = currentFee + 1; // Increment fee
	$('.num').text(newFee); // Update the displayed number
	$('#fee').val(newFee); // Update hidden input value for fee
});

// Handle minus button click
$(document).on('click', '.minus', function () {
	var currentFee = parseInt($('.num').text()); // Get current fee
	if (currentFee > 0) { // Ensure fee doesn't go below 0
		var newFee = currentFee - 1; // Decrement fee
		$('.num').text(newFee); // Update the displayed number
		$('#fee').val(newFee); // Update hidden input value for fee
	}
});

function validateFields () {

	// Validate SelectImpound
	if ($($selectionInput).val() === '') {
		$($selectionInput).css('border', '2px solid red');
	} else {
		$($selectionInput).css('border', 'none');
	}
	
	// Validate impound-fee
	if ($($Impoundfee).val() === '' || $('#fee').val() <= 0) {
		$($Impoundfee).css('border', '2px solid red');
	} else {
		$($Impoundfee).css('border', 'none');
	}
};

function hideImpoundContainer() {
	$impoundContainer.slideUp(250).fadeOut(250);
};

function handleImpoundSubmit() {
	if (!validateFields()) return;

	const data = {
		Fee: $Impoundfee.val(),
		Selection: $selectionInput.val(),
	};

	$.post("https://PoliceImpound/impomdVehicle", JSON.stringify(data));
	hideImpoundContainer();
};

function handleImpoundCancel() {
	hideImpoundContainer();
}

function handleretriveImpound() {
	if(!validateFields()) return;

	$.post("https://PoliceImpound/removeImpound", JSON.stringify({}));
	hideImpoundContainer()  ;
}

function handleCloseImpound() {
	hideImpoundContainer();
}

window.addEventListener("message", (event) => {
	const item = event.data;

	if (item.type === "init") {
		displayPoliceContainer(item.visible);
	}

	if (item.visible === false || item.type === "remove") {
		$(".ImpoundContainer").hide();
	}
});

// Use event delegation for submit, cancel, and close actions
$(document).on("click", ".impound-submit", handleImpoundSubmit);
$(document).on("click", ".impound-cancel", handleImpoundCancel);
$(document).on("click", ".Close-impound", handleCloseImpound);
$(document).on("click", ".impound-retrive", handleretriveImpound);