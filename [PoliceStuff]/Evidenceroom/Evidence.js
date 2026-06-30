$(document).ready(() => {

    // ---------------------------
    // Utility
    // ---------------------------
    function setVisible(state, el) {
        state ? el.fadeIn() : el.fadeOut();
    }

    const elements = {
        ShowHUDUI: $(".EvidencePupOut"),
        ShowCruise: $(".ReceiveEvidence")
    };

    setVisible(false, elements.ShowHUDUI);
    setVisible(false, elements.ShowCruise);

    // ---------------------------
    // NUI MESSAGE HANDLER
    // ---------------------------
    window.addEventListener("message", (event) => {
        const item = event.data;
        if (!item) return;

        switch (item.type || item.action) {
            case "hide":
                setVisible(false, elements.ShowHUDUI);
                setVisible(false, elements.ShowCruise);
                break;

            case "Policebox":
                setVisible(true, elements.ShowHUDUI);
                break;

            case "CheckEvidence":
                setVisible(true, elements.ShowCruise);
                break;
        }
    });

    // ---------------------------
    // CLICK HANDLERS (BOUND ONCE)
    // ---------------------------
    $(".CheckEvidence").on("click", () => {
        $.post("https://Evidenceroom/CheckEvidence", "{}");
    });

    $(".Evidence").on("click", () => {
        $.post("https://Evidenceroom/Evidence", "{}");
    });

    $(".Evidencelocker").on("click", () => {
        $.post("https://PoliceEvidence/Evidencelocker", "{}");
    });

    $(".Deposcontent").on("click", () => {
        $.post("https://Evidenceroom/Deposcontent", "{}");
    });

    $(".close, .displaycontent").on("click", () => {
        $.post("https://Evidenceroom/close", "{}");
    });

    // ---------------------------
    // KEYBOARD NAVIGATION
    // ---------------------------
    const buttons = document.querySelectorAll('.EvidencePupOut button');
    let currentIndex = 0;

    function highlightButton(index) {
        buttons[index].style.border = '5px solid red';
    }

    function removeHighlight(index) {
        buttons[index].style.border = 'none';
    }

    function applyBlur(button) {
        button.style.filter = 'blur(2px)';
    }

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

                // FIXED: Send a proper NUI message
                $.post("https://Evidenceroom/ButtonSelect", JSON.stringify({
                    button: buttons[currentIndex].dataset.action || buttons[currentIndex].id
                }));

                break;
        }
    });
});
