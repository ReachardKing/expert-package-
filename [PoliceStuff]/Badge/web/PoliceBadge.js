
$(document).ready(function() {
    const elements = { displaybadge: $("body")}
        
    function setEleVisible(state, el)
    {
        state ? el.fadeIn() : el.fadeOut()
    }

    setEleVisible(false, elements.displaybadge);
	
	function displaybadgecontent(data)
	{
		$('#badgeName').val(data.name || '');
		$('#badgeRank').val(data.rank || '');
		$('#badgeDate').val(data.date || '');
		$('#badgeSignature').val(data.signature || '');
		data.badgeImage = data.badgeImage || 'LSPD.png'; // Default image if not provided
	}

	window.addEventListener("message", (event) => {
		const data = event.data;

		switch (data.type || data.action) {
			case "Status":
				setEleVisible(true, elements.displaybadge)
				break
			case "updateBadge":
				displaybadgecontent(data)
				break
			case "hide":
				setEleVisible(false, elements.displaybadge)
				break
			default:
				break
		}
	})
});