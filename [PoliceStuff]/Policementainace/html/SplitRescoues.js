window.onload = async () => {
    const spawnButton = document.querySelector('.spawn');
    const CancelButton = document.querySelector('.Cancel');
    const modelsElem = document.querySelector('.options');
    const Extras = document.querySelector("#carStuff");
    const both = document.querySelector(".update");
    const primary = document.querySelector("#primary");
    const secondary = document.querySelector("#secondary");
    const fixit = document.querySelector(".fix");
    const deleteveh = document.querySelector(".delete");
    
    
    modelsElem.innerHTML = '';
    Extras.innerHTML = '';
    
    modelsElem.disable = true;
    Extras.disable = true;
    spawnButton.disable = true;
    CancelButton.disable = true;
    both.disable = true;
    fixit.disable = true;
    deleteveh.disable = true;

    const response = await fetch('SplitRescoues.json', {
        method: 'GET',
        headers : { 
            'Content-Type': 'application/json',
            'Accept': 'application/json'
        }
    })
    
    const json = await response.json()

    for (const element of json) {
        modelsElem.innerHTML += `<option value="${element.Name}">${element.DisplayName}</option>`
        Extras.innerHTML += `<option value="${element.extras}">${element.extras}</option>` 
    }

    modelsElem.disable = false;
    Extras.disable = false;
    spawnButton.disable = false;
    CancelButton.disable = false;
    both.disable = false;
    fixit.disable = false;
    deleteveh.disable = false;

    spawnButton.onclick = (e) => {
        fetch(`https://Policementainace/Click`, {
            method: 'POST',
            body: JSON.stringify({
                hash: modelsElem.value
            })
        })
    }

    both.onclick = () => {
        fetch(`https://Policementainace/both`, {
            method: 'POST',
            body: JSON.stringify({
                others: Extras.value || primary.value || secondary.value
            })
        })
    }

    fixit.onclick = () => {
        fetch(`https://Policementainace/fixit`, {
            method: 'POST'
        })
    }
    deleteveh.onclick = () => {
        fetch(`https://Policementainace/deleteveh`, {
            method: 'POST'
        })
    }

    CancelButton.onclick = (e) => {
        fetch(`https://Policementainace/CancelButton`, {
            method: 'POST'
        })
    }
}

window.addEventListener('message', (event) => {
    const data = event.data;

    if (typeof data.visible != 'undefined') {
        document.querySelector('.Spawn_HUD').style.display = data.visible && 'block' || 'none';
    }
})

window.onkeydown = (e) => {
    if (e.key == 'Escape' || e.key == 'Backspace') {
        fetch(`https://Policementainace/close`, {
            method: 'POST'
        })
    }
}