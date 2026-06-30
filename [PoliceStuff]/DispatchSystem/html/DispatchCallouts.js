$(document).ready(function () {
    window.addEventListener("message", (event, player, maxcalllist, shortcalls)=> {
        let data = event.data;
        const item = event.data;
        if (data.action == 'Status' || data.action === 'status') {
            NewCall(data.callID, data.timer, data.data, data.ispolice)
        }
        if (item.action == "setupUI")
        {
            if (item.data) {
                player = player,
                maxcalllist = maxcalllist,
                shortcalls = shortcalls
            }

            if(!player || maxcalllist || shortcalls) { return false || " " }
        }
    })
});

function NewCall(callID, timer, info, ispolice) {
	if(!info || typeof info !==  'Object'){
		console.warn(' Invalid call info received:', info)
		return;
	}
	
    let dispatchItem;

    if (info['911']) {
        dispatchItem = `<div class="sec-one waypoint" ${ispolice}><div style="background: #777; color: white; width: 83px; height: 20px; border-radius: 5px; text-align: center;"><i class="fa-solid fa-timer"></i>${info.customName}</div>
            <div style="background:crimson; color: white;  width: 73px; height: 20px; border-radius: 5px;"><i class="fa-solid fa-circle-exclamation"></i>${info.customName}</div>
            <div style="background: #777; color: white; width: 73px; height: 20px; font-size: 11px;"><i class="fa-solid fa-info"></i></div>
            <div style="background: transparent; color: white; width: 73px; height: 20px; font-size: 11px;"><i class="fa-solid fa-location-dot"></i>${info.street}</div>
            <div style="background: transparent; color: white; width: 73px; height: 20px; font-size: 11px;"><i class="fa-solid fa-file-lines"></i>${info.message}</div>
            <div style="background: transparent; color: white; width: 73px; height: 20px; font-size: 11px;"><i class="fa-solid fa-file-lines"></i>${info.icon}</div>
            <div style"background: transparent; color: white; width: 73px hight: 20px; dont-size: 11px; <i class"fa-solid fa-circle-exclamation ${info.priority}"></i></div></div>`
    }

    if (info['311']) {
        dispatchItem = `<div class="sec-two waypoint" ${ispolice}><div style="background: orange; color: white; width: 73px; height: 20px; border-radius: 5px; text-align: center;"><i class="fa-solid fa-timer"></i>${info.customName}</div>
        <div style="background: #777; color: white; width: 73px; height: 20px; font-size: 11px;"><i class="fa-solid fa-info">${info.customName}</i></div>
        <div style="background: #777; color: white; width: 73px; height: 20px; font-size: 12px;"><i class="fa-solid fa-location-dot"></i>${info.street}</div>
        <div style="background: #777; color: white; width: 73px; height: 20px; font-size: 12px;"><i class="fa-solid fa-info"></i>${info.message}</div></div>`
    }

    if (info['211']) {
        dispatchItem = `<div class="sec-three waypoint" ${ispolice}><div style="background: orange; color: white; width: 73px; height: 20px; border-radius: 5px; text-align: center;"> <i class="fa-solid fa-timer"></i>${info.customName}</div>
        <div style="background: #777; color: white; width: 73px; height: 20px; font-size: 11px;"><i class="fa-solid fa-info"></i></div>
        <div style="background: transparent; color: white; width: 73px; height: 20px; font-size: 12px;"><i class="fa-solid fa-location-dot"></i>${info.street}</div>
            <div style="background: transparent; color: white; width: 73px; height: 20px; font-size: 12px;"><i class="fa-solid fa-info"></i><${info.message}</div></div>`
    }

    if (info['Flag-plate']) {
        dispatchItem = `<div class="Flag-plate waypoint" ${ispolice}><div style="background: #777; width: 86px; height: 20px; border-radius: 5px;">${info.customName}</div>
        <div style="background: transparent; color: white; width: 73px; height: 20px; font-size: 12px;"><i class="fa-solid fa-location-dot">${info.street}</i></div>
        <div style="background: transparent; color: white; width: 73px; height: 20px; font-size: 12px;"><i class="fa-solid fa-info"></i>${info.callID}</div>
        <div style="background: transparent; color: white; width: 73px; height: 20px; font-size: 12px;"><i class="fa-solid fa-info"></i>${info.vehname}</div>
        <div style="background: transparent; color: white; width: 73px; height: 20px; font-size: 12px;"><i class="fa-solid fa-info"></i>${info.plate}</div></div>`
    }
    
    if (info['SotsFired']) {
        dispatchItem = `<div class="SotsFired waypoint" ${ispolice}><div style="background:#777; color: white; width: 83px; height: 20px; border-radius: 5px; text-align: center;"><i class="fa-solid fa-timer">${info.customName}</i></div>
        <div style="background: #777; color: white; width: 129px; height: 20px; border-radius: 5px;"><i class="fa-solid fa-circle-exclamation"></i> Shot Fired</div>
        <div style="background: #777; color: white; width: 73px; height: 20px; font-size: 11px;"><i class="fa-solid fa-info">${info.callID}</i></div>
        <div style="background: transparent; color: white; width: 73px; height: 20px; font-size: 12px;"><i class="fa-solid fa-info"></i>${info.spotted}</div>
        <div style="background: transparent; color: white; width: 73px; height: 20px; font-size: 11px;"><i class="fa-solid fa-location-dot"></i>${info.street}</div>
        <div style="background: transparent; color: white; width: 73px; height: 20px; font-size: 11px;"><i class="fa-solid fa-info"></i></div>
        <div style="background: #777; color: white; width: 129px; height: 20px; border-radius: 5px;"class="call-code priority-${info.priority}"><i class="fa-solid fa-circle-exclamation"></i>${info.priority}</div>
        </div>`
    }

    if (info['PanicButton']) {
        dispatchItem = `<div class="SotsFired waypoint" ${ispolice}><div style="background:crimson; color: white; width: 83px; height: 20px; border-radius: 5px; text-align: center;"><i class="fa-solid fa-timer">${info.customName}</i></div>
        <div style="background: #777; color: white; width: 129px; height: 20px; border-radius: 5px;"><i class="fa-solid fa-circle-exclamation"></i>${info.callID}</div>
        <div style="background: transparent; color: white; width: 73px; height: 20px; font-size: 12px;"><i class="fa-solid fa-info"></i>${info.spotted}</div>
        <div style="background: transparent; color: white; width: 73px; height: 20px; font-size: 11px;"><i class="fa-solid fa-location-dot"></i>${info.street}</div>
        <div style="background: transparent; color: white; width: 73px; height: 20px; font-size: 11px;"><i class="fa-solid fa-info"></i></div>
       <div style="background: #777; color: white; width: 129px; height: 20px; border-radius: 5px;"class="call-code priority-${info.priority}"><i class="fa-solid fa-circle-exclamation"></i>${info.priority}</div>
        </div>` 
    }

    dispatchItem  += `<div></div>`;

    var timer = 4000;

    if (prio == 1) {
        timer = 12000;
    } else if(prio == 2) {
        timer = 900;
    }
    
    $(`.${callID}`).addClass('animate_InRight');
    setTimeout(() => {
        $(`.${callID}`).addClass('animate_outRight');
        setTimeout(() => {
            $(`.${callID}`).remove();
        }, 1000);
    }, timer || 4000);

    $(".dispatch-callouts").prepend(dispatchItem);
}