
$(document).ready(function() {
    // Define the key combinations and their corresponding actions
    const keyBindings = {
        'ALT+Shift+I': function() {
          
            console.log('Ctrl + Shift + I pressed');
            // Add your action here
        },
        'ALT+Shift+U': function() {  
            console.log('Ctrl + Shift + U pressed');
            // Add your action here
        },
        'ALT+Shift+N': function() {
            console.log('Ctrl + Shift + N pressed');
            // Add your action here
        },
        'ALT+Shift+K': function() {
            console.log('Ctrl + Shift + K pressed');
            // Add your action here
        }
    };

    // Listen for keydown events
    $(document).keydown(function(event) {
        let keys = [];
        if (event.ctrlKey) keys.push('ALT');
        if (event.shiftKey) keys.push('Shift');
        if (event.altKey) keys.push('Alt');
        keys.push(event.key);

        if (event.ctrlKey) keys.push('ALT');
        if (event.shiftKey) keys.push('Shift');
        if (event.altKey) keys.push('I');
        keys.push(event.key);

        if (event.ctrlKey) keys.push('ALT');
        if (event.shiftKey) keys.push('Shift');
        if (event.altKey) keys.push('U');
        keys.push(event.key);


        if (event.ctrlKey) keys.push('ALT');
        if (event.shiftKey) keys.push('Shift');
        if (event.altKey) keys.push('N');
        keys.push(event.key);

        if (event.ctrlKey) keys.push('ALT');
        if (event.shiftKey) keys.push('Shift');
        if (event.altKey) keys.push('K');
        keys.push(event.key);


        const keyCombination = keys.join('+');

        // Check if the key combination exists in our bindings
        if (keyBindings[keyCombination]) {
            event.preventDefault(); // Prevent default action
            keyBindings[keyCombination](); // Call the corresponding action
        }
    });
})