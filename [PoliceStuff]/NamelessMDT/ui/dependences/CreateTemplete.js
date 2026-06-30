// //[[ Ensure jQuery is loaded
// $(document).ready(function() {

//     const roles = [
//         {key: "Incident Report Template", value: "Incident Report Template"},
//         {key: "Arrest Template", value: "Arrest Template"},
//         {key: "Citation Template", value: "Citation Template"},
//         {key: "Arrest Warrant Template", value: "Arrest Warrant Template"}
//     ];

//     function CreateDebriefTemplate(selectedRoleKey) {
//         const selectedRole = roles.find(role => role.value.trim() === selectedRoleKey.trim());

//         const validRoles = selectedRole ? [selectedRole] : roles.filter(role => role.key === "Incident Report Template");

//         const debriefTemplate = validRoles.map(() => GenerateTemplates()).join('');
//         $("#Incident-Debrief").html(debriefTemplate);
//     }

//     function GenerateTemplates() {
//         return `
//         <div style="background:transparent; color:white;">
//             <div style="text-align:center; margin-bottom:20px;">
//                 <h1 style="margin-bottom:15px">Officer's name & badge number</h1>
//                 <h1 style="margin-bottom:15px">Suspect's name & crime committed</h1>
//                 <h1 style="margin-bottom:15px">Suspect's vehicles used</h1>
//                 <h1 style="margin-bottom:15px">Description of incident</h1>
//                 <h1 style="margin-bottom:15px">Witness statement</h1>
//                 <h1 style="margin-bottom:15px">Date & time of incident</h1>
//                 <h1 style="margin-bottom:15px">Location of incident</h1>
//                 <h1 style="margin-bottom:10px">Others who witnessed, medical, DOJ, etc.</h1>
//             </div>
//         </div>`;
//     }

//     $(document).on("change", "#textareaoptions", function () {
//         let selectedOption = $(this).val()?.trim() || "Incident Report Template";
//         CreateDebriefTemplate(selectedOption);
//     });
//     if (roles.key[0] === roles.value[0]) {
//         CreateDebriefTemplate(); 
//     }
// });
// ]]

// $(document).ready(function () {

//     //
//     // 1. TEMPLATE REGISTRY
//     //
//     const TemplateRegistry = (function () {
//         const templates = {
//             incidentReport: {
//                 id: "incidentReport",
//                 name: "Incident Report Template",
//                 fields: [
//                     { name: "officerName", label: "Officer's name & badge number", type: "text", required: true },
//                     { name: "suspectName", label: "Suspect's name & crime committed", type: "text", required: true },
//                     { name: "vehiclesUsed", label: "Suspect's vehicles used", type: "text" },
//                     { name: "incidentDescription", label: "Description of incident", type: "textarea", required: true },
//                     { name: "witnessStatement", label: "Witness statement", type: "textarea" },
//                     { name: "incidentDateTime", label: "Date & time of incident", type: "datetime-local" },
//                     { name: "incidentLocation", label: "Location of incident", type: "text" },
//                     { name: "othersInvolved", label: "Others who witnessed, medical, DOJ, etc.", type: "textarea" }
//                 ]
//             },
//             arrest: {
//                 id: "arrest",
//                 name: "Arrest Template",
//                 fields: [
//                     { name: "officerName", label: "Officer's name & badge number", type: "text", required: true },
//                     { name: "suspectName", label: "Suspect's name", type: "text", required: true },
//                     { name: "charges", label: "Charges", type: "textarea", required: true },
//                     { name: "arrestLocation", label: "Location of arrest", type: "text" },
//                     { name: "arrestDateTime", label: "Date & time of arrest", type: "datetime-local" }
//                 ]
//             },
//             citation: {
//                 id: "citation",
//                 name: "Citation Template",
//                 fields: [
//                     { name: "officerName", label: "Officer's name & badge number", type: "text", required: true },
//                     { name: "offenderName", label: "Offender's name", type: "text", required: true },
//                     { name: "violation", label: "Violation", type: "textarea", required: true },
//                     { name: "fineAmount", label: "Fine amount", type: "number" },
//                     { name: "citationDateTime", label: "Date & time of citation", type: "datetime-local" }
//                 ]
//             },
//             arrestWarrant: {
//                 id: "arrestWarrant",
//                 name: "Arrest Warrant Template",
//                 fields: [
//                     { name: "suspectName", label: "Suspect's name", type: "text", required: true },
//                     { name: "suspectAddress", label: "Suspect's last known address", type: "text" },
//                     { name: "warrantReason", label: "Reason for warrant", type: "textarea", required: true },
//                     { name: "issuingJudge", label: "Issuing judge", type: "text" },
//                     { name: "issueDate", label: "Date of issue", type: "date" }
//                 ]
//             }
//         };

//         const roleMap = {
//             "Incident Report Template": "incidentReport",
//             "Arrest Template": "arrest",
//             "Citation Template": "citation",
//             "Arrest Warrant Template": "arrestWarrant"
//         };

//         return {
//             getById(id) {
//                 return templates[id] || null;
//             },
//             getByRoleName(roleName) {
//                 const id = roleMap[roleName];
//                 return id ? templates[id] : null;
//             },
//             getAll() {
//                 return Object.values(templates);
//             }
//         };
//     })();


//     //
//     // 2. TEMPLATE RENDERER
//     //
//     const TemplateRenderer = (function () {

//         function renderField(field, templateId) {
//             const fieldId = `${templateId}_${field.name}`;
//             const requiredAttr = field.required ? "required" : "";
//             const baseStyles = "width:100%; padding:8px; margin-top:5px; border-radius:4px; border:1px solid #555; background:#111; color:#fff;";

//             let inputHtml = "";

//             switch (field.type) {
//                 case "textarea":
//                     inputHtml = `
//                         <textarea id="${fieldId}" name="${field.name}" style="${baseStyles} min-height:80px;" ${requiredAttr}></textarea>
//                     `;
//                     break;
//                 default:
//                     inputHtml = `
//                         <input id="${fieldId}" name="${field.name}" type="${field.type}" style="${baseStyles}" ${requiredAttr} />
//                     `;
//                     break;
//             }

//             return `
//                 <div class="form-group" style="margin-bottom:15px; text-align:left;">
//                     <label for="${fieldId}" style="display:block; margin-bottom:5px; color:#fff;">
//                         ${field.label}${field.required ? " *" : ""}
//                     </label>
//                     ${inputHtml}
//                 </div>
//             `;
//         }

//         function renderTemplate(template) {
//             const fieldsHtml = template.fields.map(f => renderField(f, template.id)).join("");

//             return `
//                 <div class="template-card" data-template-id="${template.id}"
//                      style="background:rgba(0,0,0,0.4); color:white; border:1px solid #444; border-radius:8px; padding:20px; margin-bottom:20px;">
                    
//                     <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:15px;">
//                         <h2 style="margin:0; font-size:20px;">${template.name}</h2>
//                         <button type="button" class="template-toggle"
//                                 style="background:#222; color:#fff; border:1px solid #555; border-radius:4px; padding:4px 8px; cursor:pointer;">
//                             Collapse
//                         </button>
//                     </div>

//                     <form class="template-form">
//                         ${fieldsHtml}
//                         <div style="margin-top:15px; text-align:right;">
//                             <button type="button" class="template-save"
//                                     style="background:#2d7ef7; color:#fff; border:none; border-radius:4px; padding:8px 14px; cursor:pointer;">
//                                 Save
//                             </button>
//                         </div>
//                     </form>
//                 </div>
//             `;
//         }

//         return {
//             renderTemplate,
//             renderTemplates(templates) {
//                 return templates.map(renderTemplate).join("");
//             }
//         };
//     })();


//     //
//     // 3. TEMPLATE MANAGER
//     //
//     const TemplateManager = (function ($, registry, renderer) {

//         const containerSelector = "#Incident-Debrief";

//         function loadTemplatesByRoleNames(roleNames) {
//             const templates = roleNames
//                 .map(name => registry.getByRoleName(name))
//                 .filter(Boolean);

//             renderIntoContainer(templates);
//         }

//         function loadTemplateByRoleName(roleName) {
//             const template = registry.getByRoleName(roleName) || registry.getByRoleName("Incident Report Template");
//             renderIntoContainer([template]);
//         }

//         function loadAllTemplates() {
//             const templates = registry.getAll();
//             renderIntoContainer(templates);
//         }

//         function renderIntoContainer(templates) {
//             const html = renderer.renderTemplates(templates);
//             $(containerSelector).html(html);
//         }

//         return {
//             loadTemplateByRoleName,
//             loadTemplatesByRoleNames,
//             loadAllTemplates
//         };

//     })(jQuery, TemplateRegistry, TemplateRenderer);


//     //
//     // 4. EVENTS / INTEGRATION
//     //

//     // Dropdown change → load single template by role name
//     $(document).on("change", "#textareaoptions", function () {
//         const selected = ($(this).val() || "Incident Report Template").trim();
//         TemplateManager.loadTemplateByRoleName(selected);
//     });

//     // Toggle collapse/expand of a template card
//     $(document).on("click", ".template-toggle", function () {
//         const $card = $(this).closest(".template-card");
//         const $form = $card.find(".template-form");
//         const isHidden = $form.is(":hidden");

//         $form.toggle(!isHidden);
//         $(this).text(isHidden ? "Collapse" : "Expand");
//     });

//     // Save button handler (stub: logs data, ready to wire to backend)
//     $(document).on("click", ".template-save", function () {
//         const $form = $(this).closest(".template-form");
//         const $card = $(this).closest(".template-card");
//         const templateId = $card.data("template-id");

//         const formDataArray = $form.serializeArray();
//         const data = formDataArray.reduce((acc, field) => {
//             acc[field.name] = field.value;
//             return acc;
//         }, {});

//         console.log("Saved template:", templateId, data);

//         // TODO: send `data` to your backend, or store locally, etc.
//         // Example:
//         $.post("https://NamelessMDT/save-template", { templateId, data });

//         alert(`Template "${templateId}" data captured in console.`);
//     });

//     //
//     // 5. INITIAL LOAD
//     //
//     // Default: load Incident Report Template
//     TemplateManager.loadTemplateByRoleName("Incident Report Template");
// })

$(document).ready(function () {

    //
    // 1. TEMPLATE REGISTRY
    //
    const TemplateRegistry = (() => {

        const baseFields = {
           
            officerName: { name: "officer name", label: "Officer's name & badge number", type: "text", required: true },
            suspectName: { name: "officer name", label: "Suspect's name", type: "text", required: true },
            incidentDescription: { name: "officer name", label: "Description of incident", type: "textarea", required: true }
        };

        const templates = {
            incidentReport: {
                id: "incidentReport",
                name: "Incident Report Template",
                fields: [
                    baseFields.officerName,
                    { name: "suspectName", label: "Suspect's name & crime committed", type: "text", required: true },
                    { name: "vehiclesUsed", label: "Suspect's vehicles used", type: "text" },
                    baseFields.incidentDescription,
                    { name: "witnessStatement", label: "Witness statement", type: "textarea" },
                    { name: "incidentDateTime", label: "Date & time of incident", type: "datetime-local" },
                    { name: "incidentLocation", label: "Location of incident", type: "text" },
                    { name: "othersInvolved", label: "Others involved", type: "textarea" }
                ]
            },

            arrest: {
                id: "arrest",
                name: "Arrest Template",
                fields: [
                    baseFields.officerName,
                    baseFields.suspectName,
                    { name: "charges", label: "Charges", type: "textarea", required: true },
                    { name: "arrestLocation", label: "Location of arrest", type: "text" },
                    { name: "arrestDateTime", label: "Date & time of arrest", type: "datetime-local" }
                ]
            },

            citation: {
                id: "citation",
                name: "Citation Template",
                fields: [
                    baseFields.officerName,
                    { name: "offenderName", label: "Offender's name", type: "text", required: true },
                    { name: "violation", label: "Violation", type: "textarea", required: true },
                    { name: "fineAmount", label: "Fine amount", type: "number" },
                    { name: "citationDateTime", label: "Date & time of citation", type: "datetime-local" }
                ]
            },

            arrestWarrant: {
                id: "arrestWarrant",
                name: "Arrest Warrant Template",
                fields: [
                    baseFields.suspectName,
                    { name: "suspectAddress", label: "Suspect's last known address", type: "text" },
                    { name: "warrantReason", label: "Reason for warrant", type: "textarea", required: true },
                    { name: "issuingJudge", label: "Issuing judge", type: "text" },
                    { name: "issueDate", label: "Date of issue", type: "date" }
                ]
            }
        };

        const roleMap = Object.fromEntries(
            Object.values(templates).map(t => [t.name, t.id])
        );

        return {
            getById: id => templates[id] || null,
            getByRoleName: name => templates[roleMap[name]] || null,
            getAll: () => Object.values(templates)
        };
    })();


    //
    // 2. TEMPLATE RENDERER
    //
    const TemplateRenderer = (() => {

        function renderField(field, templateId) {
            const id = `${templateId}_${field.name || "unknown"}`;
            const required = field.required ? "required" : "";

            const input =
                field.type === "textarea"
                    ? `<textarea id="${id}" name="${field.name}" class="template-input" ${required}></textarea>`
                    : `<input id="${id}" name="${field.name}" type="${field.type}" class="template-input" ${required}>`;

            return `
                <div class="template-field">
                    <label for="${id}" class="template-label">
                        ${field.label}${field.required ? " *" : ""}
                    </label>
                    ${input}
                </div>
            `;
        }

        function renderTemplate(template) {
            const fields = template.fields
            .map(f => renderField(f, template.id)).join("");
            

            return `
                <div class="template-card" data-template-id="${template.id}">
                    <div class="template-header">
                        <h2>${template.name}</h2>
                        <button type="button" class="template-toggle">Collapse</button>
                    </div>

                    <form class="template-form">
                        ${fields}
                        <div style="text-align:right;">
                            <button type="button" class="template-save">Save</button>
                        </div>
                    </form>
                </div>
            `;
        }

        return {
            renderTemplates: templates => templates.map(renderTemplate).join("")
        };
    })();


    //
    // 3. TEMPLATE MANAGER
    //
    const TemplateManager = (($, registry, renderer) => {

        const container = "#editor-Incident-Debrief";

        function render(templates) {
            $(container).html(renderer.renderTemplates(templates));
        }

        return {
            loadTemplateByRoleName(name) {
                const template =
                    registry.getByRoleName(name) ||
                    registry.getByRoleName("Incident Report Template");

                render([template]);
            },

            loadTemplatesByRoleNames(names) {
                const templates = names
                    .map(n => registry.getByRoleName(n))
                    .filter(Boolean);

                render(templates);
            },

            loadAllTemplates() {
                render(registry.getAll());
            }
        };
    })(jQuery, TemplateRegistry, TemplateRenderer);


    //
    // 4. EVENTS
    //

    $("#textareaoptions").on("change", function () {
        TemplateManager.loadTemplateByRoleName($(this).val());
    });

    $(document).on("click", ".template-toggle", function () {
        const $form = $(this).closest(".template-card").find(".template-form");
        const hidden = $form.is(":hidden");

        $form.toggle();
        $(this).text(hidden ? "Collapse" : "Expand");
    });

    $(document).on("click", ".template-save", function () {
        const $form = $(this).closest(".template-form");
        const templateId = $(this).closest(".template-card").data("template-id");

        const data = Object.fromEntries(
            $form.serializeArray().map(f => [f.name, f.value])
        );

        console.log("Saved template:", templateId, data);

        $.post("https://NamelessMDT/save-template", { templateId, data });

        alert(`Template "${templateId}" saved.`);
    });


    //
    // 5. INITIAL LOAD
    //
   TemplateManager.loadTemplateByRoleName("Incident Report Template");
});