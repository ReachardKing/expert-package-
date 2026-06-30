
$(document).ready(() => {
    const Jailmanagement = {
        Jailbreak: $("#JailBreak"),
        changing: $(".ViewContent")
    }

    SetElement(false, Jailmanagement.Jailbreak);
    SetElement(false, Jailmanagement.changing);

    function SetElement(state, ele)
    {
        state ? ele.show() : ele.hide();
    }

    // $(".custominput").html(`
    //     <span class="minus">-</span>
    //     <span class="num">0</span>
    //     <span class="plus">+</span>
    // `);

    window.addEventListener("message", (event) => {
        const item = event.data;
        

        item.firstname = item.firstname || '';
        item.lastname = item.lastname || '';
        
        if (item.status) { return }

        switch (item.type || item.action) {
            case "index":
                if (item.status) {
                    SetElement(true, Jailmanagement.Jailbreak);
                } else {
                    SetElement(false, Jailmanagement.Jailbreak)
                }
                break
            case "JailIndex":
                SetElement(true, Jailmanagement.changing);
                break
            case "closeAll":
                SetElement(false, Jailmanagement.Jailbreak);
                SetElement(false, Jailmanagement.changing);
                break
            default:
                break

        }
    });

    //[$( document ).keyup( function( event ) {
    //[$( document ).keyup( function( event ) {
    //	if ( event.keyCode == 13 ) 
    //	{
    //		SetElement(Jailmanagement.Jailbreak, false)
    //		SetElement(Jailmanagement.changing, false)
    //	}
    //} );

    $( document ).keyup( function( event ) {
        if ( event.keyCode == 27 ) 
        {
            SetElement(Jailmanagement.Jailbreak, false)
            SetElement(Jailmanagement.changing, false)
        }
    } );
    // Action buttons
    const postAction = (endpoint, data = {}) => {
        $.post(`https://JailManagement/${endpoint}`, JSON.stringify(data));
    };

    $(document).on("click", ".displaycontent", () => postAction("Freedom"));
    $(document).on("click", ".cancel, .Submit, .close", () => postAction("CloseAll"));


    // Confirm submit
    $(document).on("click", ".Submit", () => {
        const firstname = $('#Get-charcter-infomation').val();
        const lastname = $('#Get-charcter-infomation').val();

        if (firstname && lastname) {
            $('#Get-charcter-infomation').html(`
                <option class="select" value="${firstname} ${lastname}">
                    ${firstname} ${lastname}
                </option>
            `);

            postAction("Submit", {
                firstname,
                lastname,
            });
            postAction("CloseAll");
        }

        $('#Charactercontent').append(`${firstname} ${lastname}`);
    });

    // Cancel clear
    $(document).on("click", ".Cancel", () => {
        $('#Get-charcter-infomation').val('');
        postAction("CloseAll");
    });
})