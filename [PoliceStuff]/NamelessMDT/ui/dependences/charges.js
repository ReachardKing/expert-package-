
$(document).ready(function() {
    // Update the fee area with custom buttons
    $(".custominput").html(`
        <span class="minus">-</span>
        <span class="num">0</span>
        <span class="plus">+</span>
    `);

    // Handle plus button click
    $(document).on('click', '.plus', function() {
        var currentFee = parseInt($('.num').text()); // Get current fee
        var newFee = currentFee + 1; // Increment fee
        $('.num').text(newFee); // Update the displayed number    
    });

    // Handle minus button click
    $(document).on('click', '.minus', function() {
        var currentFee = parseInt($('.num').text()); // Get current fee
        if (currentFee > 0) { // Ensure fee doesn't go below 0
            var newFee = currentFee - 1; // Decrement fee
            $('.num').text(newFee); // Update the displayed number
        };
    });
});