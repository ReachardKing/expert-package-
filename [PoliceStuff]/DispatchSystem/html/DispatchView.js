
window.addEventListener("message", ((event)=> {
    let data = event.data;
    if (data.type == 'DispatchView' || data.type === 'DispatchView' && data.visible) {
        let dispatchView = document.createElement('div');
        let dispatchImage = document.createElement('img');
        let mainimage = `../html/DispatchView.jpeg`;
        dispatchView.appendChild(dispatchImage);
        dispatchImage.src = mainimage;
        dispatchImage.style.width = '100%';
        dispatchImage.style.height = '100%';
        dispatchImage.style.objectFit = 'cover';
        dispatchImage.style.position = 'absolute';
        dispatchView.className = 'dispatchImage';
        dispatchImage.style.top = '0';
        dispatchImage.style.left = '0';
        dispatchImage.style.zIndex = '-1';
    }
}))

	window.addEventListener("keyup", (e) => {
		if (e.key == 'Escape' || e.key == "Backspace" && $("#wrapper").is(':visible')) {
            $(".dispatchImage").fadeOut();
			$.post(`https://DispatchSystem/close`, JSON.stringify({}));

		}
	})
