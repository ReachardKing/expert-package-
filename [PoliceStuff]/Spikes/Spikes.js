
$(".Spikes_HUD").hide();
window.addEventListener("message", (event) => {
    const item = event.data;
                
    if (item.action != undefined && item.action === 'SpikesIt') {
        if (item.visible = true) {
            $(".Spikes_HUD").show();
        } else {
            $(".Spikes_HUD").hide();
        }
    }
    
    $(".Spikes").text(item.Spikes)
    $(".Pickup").text(item.pickup)
    
    $(".Spikes").click(()=> {
        $.post(`https://Spikes/SetSpikes`, JSON.stringify({}))
    })
    
    $(".Pickup").click(()=> {
        $.post(`https://Spikes/PickupSpikes`, JSON.stringify({}))
    })
}) 

document.addEventListener('DOMContentLoaded', () => {
    const buttons = document.querySelectorAll('.Spikes_HUD button');
    let currentIndex = 0;

    // Initial highlight
    highlightButton(currentIndex);

    document.addEventListener('keydown', (event) => {
        switch (event.key) {
            case 'ArrowDown':
                removeHighlight(currentIndex);
                currentIndex = (currentIndex + 1) % buttons.length;
                highlightButton(currentIndex);
                break;

            case 'ArrowUp':
                removeHighlight(currentIndex);
                currentIndex = (currentIndex - 1 + buttons.length) % buttons.length;
                highlightButton(currentIndex);
                break;

            case 'Enter':
                applyBlur(buttons[currentIndex]);
				SendNUIMessage(buttons[currentIndex], {})
                break;
            default:
                break;
        }
    });

    function highlightButton(index) {
        buttons[index].style.border = '5px solid red';
    }

    function removeHighlight(index) {
        buttons[index].style.border = 'none';
    }

    function applyBlur(button) {
        button.style.filter = 'blur(2px)';
    }
});