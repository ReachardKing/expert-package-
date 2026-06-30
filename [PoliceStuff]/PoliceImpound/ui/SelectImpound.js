
// const elements = {
//     openimpound: $(".ImpoundSettings"),
//     impoundlist: $("#impoundlist"),
//     Buyformlist: $("#BuypersonalVehicle"),
//     manageitemselect: $("#manage-item-select"),
//     Policeimpound: $(".Policeimpound"),
//     NormalImpound: $(".Normalimpound"),
//     Raidimpound: $(".Raidimpound"),
//     HaysImpound: $(".Haysimpound"),
//     Buyvehicles: $(".Buyvehicle"),
//     Removeformlist: $(".Removeformlist"),
// }

// elements.openimpound.show();
// elements.Buyformlist.hide();
// elements.impoundlist.hide();

// function NewElement(state, ele)
// {
//     state ? ele.fadeIn() : ele.fadeOut()
// }

// window.addEventListener("message", (event)=> {
//     const items = event.data;
//     const type = event.data;
//     const action = event.data;

//     switch (type || items || action) {
//         case "Select":
//             NewElement(elements.openimpound, true);
//         case "lists":
//             NewElement(elements.Buyformlist, true);
//         default:
//             break   
//     }

//     const SendNUIMessage = (name, data, calback) => {
//         $.post(`https://VehImpound/${name}`, JSON.stringify(data, calback))
//     }
    
//     elements.impoundlist.append(`<div class="Removeformlist" style="width: 100%; height:20px; position: relative; background: grey; border: 2px solid crimson; transition: 0.5; cursor: pointer; margin-bottom: 10px;  text-align: center;">${items.name}</div>`)
//     elements.Buyformlist.append(`<div style="width: 100%; position: absolute; background: transparent; border: 2px solid crimson; transition: 0.5s; cursor: pointer;" id="manage-item-select">
//         <div style="width: 50%; float: left; text-align: left;">
//             <p id="Model"></p>
//             <p id="bodyhealth"></p>
//             <p id="Plate"></p>
//         </div>
//         <div style="width:50%; display:inline-block; text-align: center;">
//             <p id="name"></p>
//             <P id="bodyclass"></P>
//             <p></p>
//         </div>
//     </div>`)

//     elements.Policeimpound.click(()=> {
//         NewElement(elements.impoundlist, true);
//     })

//     elements.Removeformlist.click(()=> {
//         SendNUIMessage("chosen")
//     })

//     element.manageitemselect.click(()=> {
//         SendNUIMessage("manageitemselect");
//     })

//     elements.Buyvehicles.click(()=>{
//         $("#BuypersonalVehicle").slideDown();
//         $("#BuypersonalVehicle").fadeIn();
//     })

//     // Close UI
//     elements[Policeimpound, NormalImpound, Raidimpound, HaysImpound].click(()=> {
//         SendNUIMessage("close");
//     })

//     elements.manageitemselect.click(()=> {
//         $("#BuypersonalVehicle").slideUp();
//         $("#BuypersonalVehicle").fadeOut();
//     })
// })

// window.onkeydown = (e) => {
//     if (e.key == 'Escape' || e.key == 'Backspace') {
//         fetch(`https://${GetParentResourceName()}/close`, {
//             method: 'POST'
//         })
//     }
// }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////// New code //////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////

const elements = {
    openimpound: $(".ImpoundSettings"),
	Closeimpound: $(".close-quote"),
    impoundlist: $("#impoundlist"),
    buyFormList: $("#BuypersonalVehicle"),
    manageItemSelect: $("#manage-item-select"), // button
    policeImpound: $(".Policeimpound"), // button
    normalImpound: $(".Normalimpound"), // button
    raidImpound: $(".Raidimpound"), // button
    haysImpound: $(".Haysimpound"), // button
    Buyvehicles: $(".Buyvehicle"), // button
    removeFormList: $(".Removeformlist"), // button
};

function toggleElement(element, state) {
    state ? $(element).fadeIn() : $(element).fadeOut();
}

function sendNUIMessage(name, data) {
    $.post(`https://PoliceImpound/${name}`, JSON.stringify(data));
}

toggleElement(elements.openimpound, true);
toggleElement(elements.impoundlist, false);
toggleElement(elements.buyFormList, false);

window.onload = (event) => {
    const {data} = event;

    if (data || data.items) {
        elements.impoundlist.prepend(`
            <div class="Removeformlist" style="width: 100%; height: 20px; position: relative; background: grey; border: 2px solid crimson; transition: 0.5s; cursor: pointer; margin-bottom: 10px; text-align: center;">
                ${data.items.plate || ''}
            </div>
            <P> Contact the mechanic when there is a problem eg wrong selection of a vehicle.</p>
        `);

        elements.buyFormList.prepend(`
            <div style="width: 100%; position: absolute; background: transparent; border: 2px solid crimson; transition: 0.5s; cursor: pointer;" id="manage-item-select">
                <div style="width: 50%; float: left; text-align: left;">
                    <p id="Model">${data.model || ''}</p>
                    <p id="bodyhealth">${data.bodyhealth || ''}</p>
                    <p id="Plate">${data.plate || ''}</p>
                </div>
                <div style="width: 50%; display: inline-block; text-align: center;">
                    <p id="name">${data.name || ''}</p>
                    <p id="bodyclass">${data.bodyclass || ''}</p>
                </div>
            </div>
        `);
    
    }
}

window.addEventListener("message", (event) => {
    const item = event.data;

    switch (item.data || item.type || item.action) {
        case "Select":
            toggleElement(elements.openimpound, true);
		case "remove":
			toggleElement(elements.openimpound, false)
			toggleElement(elements.impoundlist, false)
			break;
        default:
            break;
    }
})

// Impound buttons
const impoundButtons = [
    elements.policeImpound,
    elements.normalImpound,
    elements.haysImpound,
    elements.raidImpound
];

// Close Impound UI
elements.closeImpound?.click(() => {
    toggleElement(elements.openimpound, false);
    sendNUIMessage("close", {});
});

// Open selected impound list
impoundButtons.forEach(button => {
    button?.click(() => {
        toggleElement(elements.impoundlist, true);
        toggleElement(elements.openimpound, false);

        // Notify Lua/client
        sendNUIMessage("close", {});
    });
});

// Remove from list
elements.removeFormList?.click(() => {
    toggleElement(elements.impoundlist, false);
    toggleElement(elements.openimpound, false);

    sendNUIMessage("chosen", {});
});

// Manage item selection
elements.manageItemSelect?.click(() => {
    toggleElement(elements.buyFormList, false);

    sendNUIMessage("manageitemselect", {});
    sendNUIMessage("lists", {});
});

// Open vehicle shop list
elements.Buyvehicles?.click(() => {
    toggleElement(elements.buyFormList, true);
});

// Secondary close button
elements.Closeimpound?.click(() => {
    toggleElement(elements.openimpound, false);
}); 
elements.Buyvehicles.click(() => { toggleElement(elements.buyFormList, true); });
    
[elements.policeImpound, elements.normalImpound, elements.raidImpound, elements.haysImpound].forEach(el => {
    el.click(() => sendNUIMessage("close", {}));
});

const impoundElements = [elements.policeImpound, elements.normalImpound, elements.raidImpound, elements.haysImpound];
    
impoundElements.forEach(el => {
    el.click(() => sendNUIMessage("close", {}));
});

elements.Closeimpound.click(()=> {
    toggleElement(elements.openimpound, false);
})

// Create a search input for filtering impound list
$("#search").on("input", function() {
    const searchTerm = $(this).val().toLowerCase();
    $(".Removeformlist").each(function() {
        const itemText = $(this).text().toLowerCase();
        $(this).toggle(itemText.includes(searchTerm));
    });
});

document.addEventListener('DOMContentLoaded', () => {
    const buttons = document.querySelectorAll('.ImpoundSettings button');
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
