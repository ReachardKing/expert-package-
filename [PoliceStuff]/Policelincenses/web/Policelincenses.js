// const Delay = (ms) => new Promise(res => setTimeout(res, ms));

// document.onkeyup = function(data) {
//     if(data.key == 27 || 13) {
//         $.post(`https://GrantGUNLincense/close`, JSON.stringify({}))
//     }
// };

// function opeenMenu(page) {
//     switch (page.data.action) {
//         case 'show':
//             $(".Grantlicenses").show();
//             page.data.action = openlicesedID;
//             break;
//         case 'hide':
//             $(".Grantlicenses").hide();
//         break;
//     }

//     switch (page.data.type) {
//         case 'show':
//             $("#Policelincenses").show();
//             break
//         case 'hide':
//             $("#Policelincenses").hide();
//         break;

//     }
// }

// $(function(){

//     $("#manage-license-stuff").hide();
//     $(".Grantlicenses").hide();
//     $("#Policelincenses").hide();

//     window.addEventListener("message", ((event)=>{

//         opeenMenu(event)

//         const item = event.data;

//         $(".Submit").click(()=> {
//             $("#manage-license-stuff").slideUp();
//             $("#manage-license-stuff").fadeOut();
//         })

//         $("#RevokeGunlicense, #GrantgUNlicense, #GrantHuntinglicense, #GrantSkipperliicense, #RevokeSkipperlicense").click(()=> {
//             $("#manage-license-stuff").slideUp();
//             $("#manage-license-stuff").fadeOut();
//         })

//         $("#PlayerName").text(item.PlayerName);
//         $(".WeaponName").text(item.WeaponName);

//         $(".close").click(()=> {
//             $.post(`https://Policelincenses/choosetest`, JSON.stringify({}))
//             opeenMenu(false);
//         })

//         $(".Cancel").click(()=> {
//             $.post(`https://Policelincenses/choosetest`, JSON.stringify({}))
//         })

//         $("#RevokeGunlicense").click(function () {
//             $.post(`https://Policelincenses/revoke`, JSON.stringify({}))
//         });

//         $("#GrantgUNlicense").click(function () {
//             $.post(`https://Policelincenses/Grant`, JSON.stringify({}))
//         });

//         $("#GrantHuntinglicense").click(function () {
//             $.post(`https://Policelincenses/Grant2`, JSON.stringify({}))
//         });

//         $("#RevokeHuntinglicense").click(function () {
//             $.post(`https://Policelincenses/revoke2`, JSON.stringify({}))
//         });

//         $("#GrantSkipperliicense").click(function () {
//             $.post(`https://Policelincenses/Grant3`, JSON.stringify({}))
//         });

//         $("#RevokeSkipperlicense").click(function () {
//             $.post(`https://Policelincenses/revoke3`, JSON.stringify({}))
//         });
//     }))
// })

const delay = ms => new Promise(res => setTimeout(res, ms));

$(document).ready(() => {

    const Elements = {
        license: $("#manage-license-stuff"),
        GrantLicenses: $(".Grantlicenses"),
    }

    function SetElement(element, display) {
        display ? element.fadeIn() : element.fadeOut();
    }

    SetElement(Elements.license, false);
    SetElement(Elements.GrantLicenses, true);

    document.onkeyup = function (event) {
        if (event.key === "Escape") {
            $.post(`https://PoliceLicenses/close`, JSON.stringify({}));
        }
    };

    function openMenu(page) {
        if (!page || !page.data) return;

        const { action } = page.data;

        if (action === 'show') {
            SetElement(Elements.GrantLicenses, true);
        } else if (action === 'hide') {
            SetElement(Elements.GrantLicenses, false);
        }
    }

    const CSN = $("#Searched-name");
    const firstname = $("firstname");
    const lastname = $("#last-name");
    const DOB = $("#DOB");

    window.addEventListener('message', function(event) {
        const data = event.data;
    
        if (data.action === "updatelicense") {
            $.post(`https://PoliceLicenses/updatelicense`, JSON.stringify({ CSN: data.CSN }))
            $(firstname).val(data.firstname || '');
            $(lastname).val(data.lastname || '');
            $(DOB).val(data.date || '');
        }
    });

    function resetlicenses() {
        CSN.val(' ');
    }

    function showErrorBorder(Element) {
        Element.css("border", "1px solid rgb(184, 3, 3)");
        setTimeout(() => {
            Element.css("border", "1px solid rgb(184, 3, 3)");
        }, 500);
    };

    function validateFields() {
        let isValid = true;

        if (!CSN.val()) {
            showErrorBorder(CSN);
            isValid = false;
        };

        return isValid;
    };

    function hidePolicelicenses() {
        SetElement(Elements.GrantLicenses, false);
        SetElement(Elements.license, true);
    }

    function HandlepolicelicensesSubmit() {
        if (!validateFields) return;
        hidePolicelicenses()

        $.post(`https://PoliceLicenses/GetCSN`, JSON.stringify({ CSN: CSN.val() }));
        resetlicenses();
    }

    function setupLicenseActions() {

        $(document).on('click',"#RevokeGunLicense", ()=> {
            $.post(`https://PoliceLicenses/revoke`, JSON.stringify({}));
        });

        $(document).on('click', "#GrantGunLicense", ()=> {
            $.post(`https://PoliceLicenses/grant`, JSON.stringify({}));
        });

        $(document).on('click', "#GrantHuntingLicense", ()=> {
            $.post(`https://PoliceLicenses/grant2`, JSON.stringify({}));
        });

        $(document).on('click', "#RevokeHuntingLicense", ()=> {
            $.post(`https://PoliceLicenses/revoke2`, JSON.stringify({}));
        });

        $(document).on('click', "#GrantSkipperLicense", ()=> {
            $.post(`https://PoliceLicenses/grant3`, JSON.stringify({}));
        });

        $(document).on('click', "#RevokeSkipperLicense", ()=> {
            $.post(`https://PoliceLicenses/revoke3`, JSON.stringify({}));
        });
    }
    
    window.addEventListener("message", (event) => {
        openMenu(event);
        const { PlayerName, WeaponName } = event.data;

        $("#PlayerName").text(PlayerName);
        $(".WeaponName").text(WeaponName);

        setupLicenseActions();
    });

    $(document).on("click", "#RevokeGunLicens", (()=> { hidePolicelicenses()}));

    $(document).on("click", "#RevokeSkipperLicense", (()=> { hidePolicelicenses()}));

    $(document).on("click", "#GrantSkipperLicense", (() => {hidePolicelicenses()}));
        
    $(document).on("click"," #GrantGunLicense", (() => {hidePolicelicenses()}));

    $(document).on("click", "#GrantHuntingLicense", (() => {hidePolicelicenses()}));
    
    $(document).on("click", ".Submit", (() => {HandlepolicelicensesSubmit()}));

    $(".close").click(() => {
        hidePolicelicenses();
    });

    $(".Cancel").click(() => {
        hidePolicelicenses();
    });
});