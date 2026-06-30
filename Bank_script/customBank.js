
$(document).ready(()=> {

    // Manage Access

    $(".spinner").hide();

    $(document).on("click", ".close", ()=>{
        $(".spinner").fadeIn(11800);
        $(".spinner").fadeOut(800);
    });

    $(document).on("click", ".PoofAccount", ()=> {
        $(".spinner").fadeIn(31800);
        $(".spinner").fadeOut(800);  
    });
    
    $(document).on( "click", ".customMamage", ()=> { 

        setTimeout(() => {
            $(".spinner").fadeIn(11800);
            $(".spinner").fadeOut(800);
        }, 500);
        
        $("#customManage").slideDown();
        $("#customManage").fadeIn(); 
    });

    $(document).on( "click", ".Access", ()=> {
        
        setTimeout(() => {
            $(".spinner").fadeIn(11800);
            $(".spinner").fadeOut(800);
        }, 500);
        
        $(".UserAccess").slideDown();
        $(".UserAccess").fadeIn();
    })

    $(".customDeposit, .customWithdraw, .customTransfer").click(()=> {
        
        setTimeout(() => {
            $(".spinner").fadeIn(11800);
            $(".spinner").fadeOut(800);
        }, 500);
        
        $(".customoption").slideDown();
        $(".customoption").fadeIn(); 
    })

    $(document).on( "click", ".customRename", ()=> {
        
        setTimeout(() => {
            $(".spinner").fadeIn(11800);
            $(".spinner").fadeOut(800);
        }, 500);
        
        $("#RenamedAccount").slideDown();
        $("#RenamedAccount").fadeIn();
    })

    $(document).on( "click", ".collectPlaycheck", ()=> {
        HideAllOtherContent(true);
    })

    $(document).on( "click", "#removeaccount", ()=> {
        
        setTimeout(() => {
            $(".spinner").fadeIn(11800);
            $(".spinner").fadeOut(800);
        }, 500);
        
        $("#confirmButton").slideDown();
        $("#confirmButton").fadeIn();
    })

    $(document).on( "click", ".confirmtransactions", ()=> {
        $("#Successful").slideDown();
        $("#Successful").fadeIn();

        setTimeout(() => {
            $("#Successful").slideUp();
            $("#Successful").fadeOut();
        }, 300);
    })

    // Close All UI

    // User Access
    $(document).on("click", ".Decline", ()=> {
        
        setTimeout(() => {
            $(".spinner").fadeIn(11800);
            $(".spinner").fadeOut(800);
        }, 500);
        
        $("#customManage").slideUp();
        $("#customManage").fadeOut();
    })

    $(document).on("click", ".Decline", ()=> {
        
        setTimeout(() => {
            $(".spinner").fadeIn(11800);
            $(".spinner").fadeOut(800);
        }, 500);
        
        $(".UserAccess").slideUp();
        $(".UserAccess").fadeOut();
    })

    $(document).on("click", ".Decline", ()=> {
        $(".RenamedAccount").slideUp();
        $(".RenamedAccount").fadeOut();
    })

    $(document).on("click", ".Accept", ()=> {
        $(".UserAccess").slideUp();
        $(".UserAccess").fadeOut();
    })

    $(document).on("click", ".NewName", ()=> {
        $("#RenamedAccount").slideUp();
        $("#RenamedAccount").fadeOut();
    })

    $(document).on("click", ".KeepAccount", ()=> {
        $("#confirmButton").slideUp()
        $("#confirmButton").fadeOut()
    })

    $(document).on("click", ".PoofAccount", ()=> {
        HideAllOtherContent(true);
    })

    $(document).on("click", ".confirmDecline", ()=> {
        $("#Failed").slideDown();
        $("#Failed").fadeIn();
        
        setTimeout(() => {
            $("#Failed").slideUp();
            $("#Failed").fadeOut();
        }, 300);
    })

    $(document).on("click", ".confirmDecline, .confirmtransactions", ()=> {
        $(".customoption").slideUp();
        $(".customoption").fadeOut();
    })

    // The Big Bank
    $("#confirmButton").hide(); $("#Successful").hide(); $("#Failed").hide(); $("#Renamed").hide(); $("#RenamedFailed").hide();

    function HideAllOtherContent(bool) {
        if (bool) {
            $(".ShowBankUI, #confirmButton, #Successful, #Failed, #Renamed, #RenamedFailed").hide()
        }
    }

    HideAllOtherContent(false);
});