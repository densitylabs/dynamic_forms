//= require jsoneditor

document.addEventListener("DOMContentLoaded", function(){
  initJsonEditor();
  initJsonEditorUi();
});

initJsonEditor = function initJsonEditor(){
  const jsonEditorContainer = document.getElementById("json_editor_container");
  const jsonSchemaField = document.getElementById("custom_form_json_schema");

  const jsonEditorOptions = {
    mode: 'code',
    modes: ['code','preview'],
    sortObjectKeys: true,
    onChange: function () {
      try {
        jsonSchemaField.value = JSON.stringify(jsonEditor.get());
      } catch (e) {
        return;
      }
    }
  };
  const jsonEditor = new JSONEditor(jsonEditorContainer, jsonEditorOptions);
  jsonEditor.set(JSON.parse(jsonSchemaField.value));
}

initJsonEditorUi = function (){
  const jsonEditorContainer = document.getElementById("json_editor_container_ui");
  const uiSchemaField = document.getElementById("custom_form_ui_schema");

  const jsonEditorOptions = {
    mode: 'code',
    modes: ['code','preview'],
    sortObjectKeys: true,
    onChange: function () {
      try {
        uiSchemaField.value = JSON.stringify(jsonEditor.get());
      } catch (e) {
        return;
      }
    }
  };
  const jsonEditor = new JSONEditor(jsonEditorContainer, jsonEditorOptions);
  jsonEditor.set(JSON.parse(uiSchemaField.value));
}
