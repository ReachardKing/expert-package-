
// function display(bool) {
//     if (bool) {
//         return $("body").toggle(bool);
//     }
//     $("body").hide();
// }

// const menus = ["#characterCreator", "#characterEditor", "#exitGameMenu", "#deleteCharacterMenu", "#spawnLocation"]
// function displayMenu(menu, status) {
//     if (status) {
//         $(`#${menus}`).fadeIn("slow");
//         menus.forEach(item => {
//             if (!item.includes(menu)) {
//                 $(item).hide();
//             }
//         });
//         return;
//     }
//     $(`#${menu}`).fadeOut("slow");
// }

// function createCharacter(firstName, lastName, dateOfBirth, gender, department, id, CSN) {
//     const job = department && `(${department})`
//     if (job && (firstName.length + lastName.length + job.length) > 24) {
//         $("#charactersSection").append(`<button id="characterButton${id}" class="createdButton animated"><span>${firstName} ${lastName}${job}</span></button><button id="characterButtonEdit${id}" class="createdButtonEdit"><a class="fas fa-edit"></a> Edit</button><button id="characterButtonDelete${id}" class="createdButtonDelete"><a class="fas fa-trash-alt"></a> Delete</button>`);
//     } else {
//         $("#charactersSection").append(`<button id="characterButton${id}" class="createdButton"><span>${firstName} ${lastName}${job}</span></button><button id="characterButtonEdit${id}" class="createdButtonEdit"><a class="fas fa-edit"></a> Edit</button><button id="characterButtonDelete${id}" class="createdButtonDelete"><a class="fas fa-trash-alt"></a> Delete</button>`);
//     }
//     $(`#characterButton${id}`).click(function () {
//         displayMenu("spawnLocation", true);
//         $.post(`https://CharacterCreation/setMainCharacter`, JSON.stringify({
//             id: id
//         }));
//         return;
//     });

//     $("#Choosenclose").click(()=> {
//         display(false)
// 		$.post(`https://CharacterCreation/close`, JSON.stringify({}))
//     })

//     $(`#characterButtonEdit${id}`).click(function () {
//         displayMenu("characterEditor", true);
//         $("#newFirstName").val(firstName);
//         $("#newLastName").val(lastName);
//         $("#newDateOfBirth").val(dateOfBirth);
//         $("#newGender").val(gender);
//         $("#newDepartment").val(department);
//         $("#CreateCSN").val(CSN);
//         characterEdited = id
//         return;
//     });
//     $(`#characterButtonDelete${id}`).click(function () {
//         displayMenu("deleteCharacterMenu", true);
//         characterDeleting = id
//         return;
//     });
// }

// function CreateAllProperlengthCID(length) {
//     const CID = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
//     const CSN = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
//     let result = '';
//     const CIDLength = CID.length || CSN.length;
//     for (let i = 0; i < length; i++) {
//         result += CID.charAt(Math.floor(Math.random() * CIDLength));
//         result += CSN.charAt(Math.floor(Math.random() * CIDLength));
//     }
//     return result;
    
// }

// $("#CreateCSN").append(`CSN - <span>${CreateAllProperlengthCID(10)}</span>`);

// $("#characterCreator").submit(function () {
//     $.post(`https://CharacterCreation/close`, JSON.stringify({}))
//     $.post(`https://CharacterCreation/newCharacter`, JSON.stringify({
//         firstName: $("#firstName").val(),
//         lastName: $("#lastName").val(),
//         dateOfBirth: $("#dateOfBirth").val(),
//         gender: $("#gender").val(),
//         department: $("#department").val(),
//         CreatedCSN: $("#CreateCSN").val(),
//     }));
//     displayMenu("characterCreator", false);
//     $("#firstName, #lastName, #dateOfBirth").val("")
//     return false;
// });

// $("#characterEditor").submit(function () {
//     displayMenu("characterEditor", false);
//     $.post(`https://CharacterCreation/editCharacter`, JSON.stringify({
//         firstName: $("#newFirstName").val(),
//         lastName: $("#newLastName").val(),
//         dateOfBirth: $("#newDateOfBirth").val(),
//         gender: $("#newGender").val(),
//         department: $("#newDepartment").val(),
//         CreatedCSN: $("#CreateCSN").val(),
//         id: characterEdited
//     }));
//     return false;
// });

// $("#deleteCharacterConfirm").click(function () {
//     displayMenu("deleteCharacterMenu", false);
//     $("#characterButton" + characterDeleting).fadeOut("slow", function () {
//         $("#characterButton" + characterDeleting).remove();
//     })
//     $("#characterButtonEdit" + characterDeleting).fadeOut("slow", function () {
//         $("#characterButtonEdit" + characterDeleting).remove();
//     })
//     $("#characterButtonDelete" + characterDeleting).fadeOut("slow", function () {
//         $("#characterButtonDelete" + characterDeleting).remove();
//     })
//     $.post(`https://CharacterCreation/delCharacter`, JSON.stringify({
//         character: characterDeleting
//     }));
//     return;
// });

// $("#newCharacterButton").click(function () {
//     displayMenu("characterCreator", true);
//     return;
// });

// $("#deleteCharacterCancel").click(function () {
//     displayMenu("deleteCharacterMenu", false);
//     return;
// });

// $("#cancelCharacterCreation").click(function () {
//     displayMenu("characterCreator", false);
//     return;
// });
// $("#cancelCharacterEditing").click(function () {
//     displayMenu("characterEditor", false);
//     return;
// });

// $("#tpCancel").click(function () {
//     displayMenu("spawnLocation", false);
//     setTimeout(function () {
//         $("#spawnMenuContainer").empty();
//     }, 550);
//     return;
// });

// $("#quitGameButton").click(function () {
//     displayMenu("exitGameMenu", true);
//     return;
// });
// $("#exitGameCancel").click(function () {
//     displayMenu("exitGameMenu", false);
//     return;
// });
// $("#exitGameConfirm").click(function () {
//     $.post(`https://CharacterCreation/exitGame`, JSON.stringify({}));
//     return;
// });

// $(document).on("click", ".spawnButtons", function () {
//     const th = $(this)
//     $.post(`https://CharacterCreation/tpToLocation`, JSON.stringify({
//         x: th.data("x"),
//         y: th.data("y"),
//         z: th.data("z"),
//         id: th.data("id")
//     }));
//     displayMenu("spawnLocation", false);
//     setTimeout(function () {
//         $("#spawnMenuContainer").empty();
//     }, 550);
//     return;
// });
// $(document).on("click", "#tpDoNot", function () {
//     $.post(`https://CharacterCreation/tpDoNot`, JSON.stringify({
//         id: $("#tpDoNot").data("id")
//     }));
//     displayMenu("spawnLocation", false);
//     setTimeout(function () {
//         $("#spawnMenuContainer").empty();
//     }, 550);
//     return;
// });

// window.addEventListener("message", function (event) {
//     const item = event.data;

//     if (item.action === "Setchars") {
//         if (item.status) {
//             $("#serverName").text(item.servername);
//             $("#playerAmount").text(item.characterAmount);
//             display(true);
//         } else {
//             display(false);
//         }
//     }

//     if (item.type === "setSpawns") {
//         $("#spawnMenuContainer").empty();
//         setTimeout(function () {
//             $("#tpDoNot").data("id", item.id);
//             JSON.parse(item.spawns).forEach((location) => {
//                 $("#SpawnLoactions").append(`<button type="reset" style="margin-left: 0.2vw; background: rgb(236, 19,19); width: 8vh; height: 3vh; border-radius: 0.5vh; transition: 0.3s; cursor: pointer;" class="close"><i class="fas fa-times-circle"></i></button>
//                     <button id="SpawnButton" style="border-radius: 5px; border: none; width: 542px; height: 55px; background:blue; padding: 2px 2px; margin: 2px  0  1px; cursor: pointer;" data-x="${location.x}" data-y="${location.y}" data-z="${location.z}"> ${location.name}></button>
//                     <button id="SpawnButton" style="border-radius: 5px; border: none; width: 542px; height: 55px; background:blue; padding: 2px 2px; margin: 2px  0  1px; cursor: pointer;" data-x="${location.x}" data-y="${location.y}" data-z="${location.z}"> ${location.name}></button>
//                     <button id="SpawnButton" style="border-radius: 5px; border: none; width: 542px; height: 55px; background:red; padding: 2px 2px; margin: 2px  0  1px; cursor: pointer;" data-x="${location.x}" data-y="${location.y}" data-z="${location.z}"> ${location.name}></button>
//                     <button class="Continue" style="border-radius: 5px; border: none; width: 542px; height: 55px; background: green; padding: 2px 2px; margin: 2px 0 1px; cursor: pointer;" data-x="${location.x}" data-y="${location.y}" data-z="${location.z}"> ${location.name}></button>
//                     <button id="lastSpawnButton"style="border-radius: 5px; border: none; width: 542px; height: 55px; background:blue; padding: 2px 2px; margin: 2px  0  1px; cursor: pointer;"  class="createdButtonEdit data-x="${location.x}" data-y="${location.y}" data-z="${location.z}"> ${location.name}</button>`)
//             })
//         }, 10);
//     }

//     if (item.type === "firstSpawn") {
//         $("#tpDoNot").html(`<a class="fas fa-compass" style="color:white;"></a> Do not teleport`)
//     }

//     if (item.type === "givePerms") {
//         $(".departments").empty();
//         JSON.parse(item.deptRoles).forEach(element => {
//             $(".departments").append(`<option value="${element.name}">${element.label}</option>`);
//         });
// 	}

//     if (item.type === "aop") {
//         $("#aop").text(`AOP: ${item.aop}`);
//     }

//     if (item.type === "refresh") {
//         $("#charactersSection").empty();
//         displayMenu("characterCreator", false);
//         let characters = JSON.parse(item.characters)
//         Object.keys(characters).forEach((id) => {
//             const char = characters[id]
//             if (char) {
//                 createCharacter(
//                     char.firstname || "",
//                     char.lastname || "",
//                     char.dob || "",
//                     char.gender || "",
//                     char.metadata.ethnicity || "",
//                     char.jobInfo.label || char.job || "",
//                     char.id || "",
//                 );
//             }
//         });
//         if (item.characterAmount) {
//             $("#playerAmount").text(item.characterAmount);
//         }
//     };
// })


const menus = ["#characterCreator", "#characterEditor", "#exitGameMenu", "#deleteCharacterMenu", "#spawnLocation"]

function displayMenu(menu, status) 

{
    if (status) {
        menus.forEach(element => $(element).hide());
        $(menu).fadeIn();
    } else {
        $(menu).fadeOut();
    }
}

displayMenu("#overlay", false);

function createCharacter(firstName, lastName, dateOfBirth, id) { 
    const nameDisplay = `${firstName} ${lastName}`

    $("#charactersSection").append(` <button id="characterButton${id}" class="createdButton animated"><span>${nameDisplay}<button id="characterButtonEdit${id}" class="createdButtonEdit"><a class="fas fa-edit"></a>Edit</button><button id="characterButtonDelete${id}" class="createdButtonDelete"><a class="fas fa-trash-alt"></a>Delete</button>  <button class="Select-location"><i class="fa-solid fa-location-dot"></i></button>`);

    $("#characterButton").click(()=> {
        displayMenu("#spawnLocation", true);
        $.post(`https://CharacterCreation/setMainCharacter`, JSON.stringify({id:id}));
    });

    console.log("Creating character with data:", { firstName, lastName, dateOfBirth, id });

    $("#characterButtonEdit").click(()=> {
        displayMenu("characterEditor", true);
        $("#newFirstName").val(firstName);
        $("#newLastName").val(lastName);
        $("#newDateOfBirth").val(dateOfBirth);
        $("#newGender").val(gender);
        $("#newDepartment").val(department);
        $("#CreateCSN").val(GenerateCSN(15));
        characterEdited = id;
    })

    $(`#characterButtonDelete${id}`).click(()=> {
        displayMenu("#deleteCharacterMenu", true);
        characterButton = id
    });

    $(document).on("click", ".Select-location", ()=> {
        $("#spawnLocation").fadeIn();
    })
}

function GenerateCSN(length) {
    const chars ='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    return Array.from({length}, () => chars[Math.floor(Math.random() * chars.length)]).join( '');
}

const elements = {
    characterEditor: $("#characterCreator"),
    deleteCharacterConfirm: $("#deleteCharacterConfirm"),
    deleteCharacterCancel: $("#deleteCharacterMenu"),
    newCharacterButton: $("#newCharacterButton"),
    cancelcharacterCreation: $("#cancelCharacterCreation"),
    cancelcharacterEditing: $("#cancelCharacterEditing"),
    tpcancel: $("#tpCancel"),
    quitGameButton: $("#quitGameButton"),
    choseclose: $("#Choosenclose"),
    exitGameCancel: $("#exitGameCancel")
};

elements.characterEditor.submit(function () {
    const newCharacterData = {
        firstName: $("#firstName").val(),
        lastName: $("#lastName").val(),
        dateOfBirth: $("#dateOfBirth").val(),
        gender: $("#gender").val(),
        CreatedCSN: $("#CreateCSN").val(),
    };
    $.post('https://CharacterCreation/close', JSON.stringify({}));
    $.post('https://CharacterCreation/newCharacter', JSON.stringify(newCharacterData));
    displayMenu("#characterCreator", false);
    $("#firstName, #lastName, #dateOfBirth").val("");
    return false;
})

elements.characterEditor.submit(function () {
    const editedCharacterData = {
        firstName: $("#newFirstName").val(),
        lastName: $("#newLastName").val(),
        dateOfBirth: $("#newDateOfBirth").val(),
        gender: $("#newGender").val(),
        CreatedCSN: $("#CreateCSN").val(),
    };
    $.post('https://CharacterCreation/editCharacter', JSON.stringify(editedCharacterData));
    displayMenu("#characterEditor", false);
    return false;
});

elements.deleteCharacterConfirm.click(function () {
    displayMenu("#deleteCharacterMenu", false);
    $(`#characterButton${characterDeleting}`).fadeOut("slow", function () {
        $(this).remove();
    });
    $(`#characterButtonEdit${characterDeleting}`).fadeOut("slow", function () {
        $(this).remove();
    });
    $(`#characterButtonDelete${characterDeleting}`).fadeOut("slow", function () {
        $(this).remove();
    });
    $.post('https://CharacterCreation/delCharacter', JSON.stringify({ character: characterDeleting }));
});

elements.newCharacterButton.click(function () {
    $("#CreateCSN").html(`CSN - <span> ${GenerateCSN(15)}`);
    displayMenu("#characterCreator", true)
});

elements.deleteCharacterCancel.click(function () {
    displayMenu("#deleteCharacterMenu", false)
});

elements.cancelcharacterCreation.click(function () {
    displayMenu("#characterCreator", false)
});

elements.cancelcharacterEditing.click(function () {
    displayMenu("#characterEditor", false)
});

elements.tpcancel.click(function () {
    displayMenu("#spawnLocation", false);
    setTimeout(() => $("#spawnMenuContainer").empty(), 550);
});

elements.quitGameButton.click(function () {
    displayMenu("#exitGameMenu", true)
});

elements.exitGameCancel.click(function (e) { 
    e.preventDefault();
    displayMenu("#exitGameMenu", false)
});

elements.exitGameCancel.click(function () {
    $.post('https://CharacterCreation/exitGame', JSON.stringify({}))
    displayMenu("#exitGameMenu", false)
});


$(document).on("click", ".spawnButtons", function () {
    const th = $(this);
    $.post('https://CharacterCreation/tpToLocation', JSON.stringify({
        x: th.data("x"),
        y: th.data("y"),
        z: th.data("z"),
        id: th.data("id")
    }));
    displayMenu("#spawnLocation", false);
    setTimeout(() => $("#spawnMenuContainer").empty(), 550);
});

$(document).on("click", "#tpDoNot", function () {
    $.post('https://CharacterCreation/tpDoNot', JSON.stringify({ id: $(this).data("id") }));
    displayMenu("#spawnLocation", false);
    setTimeout(() => $("#spawnMenuContainer").empty(), 550);
});

$("#Choosenclose").click(()=> {
    displayMenu("body", false)
    $.post(`https://CharacterCreation/close`, JSON.stringify({}))
});

window.addEventListener("message", function (event) {
    const item = event.data;

    if (item.action === "Setchars") {
        displayMenu("#overlay", item.status);
        if (item.status) {
            $("#serverName").text(item.servername);
            $("#playerAmount").text(item.characterAmount);
        }
    }

    if (item.type === "setSpawns") {
        $("#spawnMenuContainer").empty();
        setTimeout(() => {
            $("#tpDoNot").data("id", item.id);
            JSON.parse(item.spawns).forEach(location => {
                const buttonHTML = `
                   <button type="reset" style="margin-left: 0.2vw; background: rgb(236, 19,19); width: 8vh; height: 3vh; border-radius: 0.5vh; transition: 0.3s; cursor: pointer;" class="close"><i class="fas fa-times-circle"></i></button>
                    <button class"SpawnButton" style="border-radius: 5px; border: none; width: 542px; height: 55px; background:blue; padding: 2px 2px; margin: 2px  0  1px; cursor: pointer;" data-x="${location.x}" data-y="${location.y}" data-z="${location.z}"> ${location.name}></button>
                    <button class"SpawnButton" style="border-radius: 5px; border: none; width: 542px; height: 55px; background:blue; padding: 2px 2px; margin: 2px  0  1px; cursor: pointer;" data-x="${location.x}" data-y="${location.y}" data-z="${location.z}"> ${location.name}></button>
                    <button class"SpawnButton" style="border-radius: 5px; border: none; width: 542px; height: 55px; background:red; padding: 2px 2px; margin: 2px  0  1px; cursor: pointer;" data-x="${location.x}" data-y="${location.y}" data-z="${location.z}"> ${location.name}></button>
                    <button class="Continue" style="border-radius: 5px; border: none; width: 542px; height: 55px; background: green; padding: 2px 2px; margin: 2px 0 1px; cursor: pointer;" data-x="${location.x}" data-y="${location.y}" data-z="${location.z}"> ${location.name}></button>
                    <button class"lastSpawnButton"style="border-radius: 5px; border: none; width: 542px; height: 55px; background:blue; padding: 2px 2px; margin: 2px  0  1px; cursor: pointer;"  class="createdButtonEdit data-x="${location.x}" data-y="${location.y}" data-z="${location.z}"> ${location.name}</button>
                `;
                $("#SpawnLoactions").append(buttonHTML);
            });
        }, 10);
    }

    if (item.type === "firstSpawn") {
        $("#tpDoNot").html(`<a class="fas fa-compass" style="color:red;"></a> Do not teleport`);
    }

    if (item.type === "refresh") {
        $("#charactersSection").empty();
        displayMenu("#characterCreator", false);
        let characters = JSON.parse(item.characters);
        Object.keys(characters).forEach(id => {
            const char = characters[id];
            if (char) {
                createCharacter(
                    char.firstname || "",
                    char.lastname || "",
                    char.dob || "",
                    char.gender || "",
                    char.ethnicity || "",
                    char.id || ""
                );
            }
        });

        if (item.characterAmount) {
            $("#playerAmount").text(item.characterAmount);
        }
    }
});