"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _reactDom = _interopRequireDefault(require("react-dom"));

var _reactJsonschemaForm = _interopRequireDefault(require("react-jsonschema-form"));

var _this = void 0;

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

var CustomForm = function CustomForm(container, jsonSchema, uiSchema) {
  _react.default.createElement("div", null, _react.default.createElement(_reactJsonschemaForm.default, {
    schema: { jsonSchema },
    uiSchema: { uiSchema }
  }));
  return renderCustomForm(container, jsonSchema, uiSchema);
};

var renderCustomForm = function (container, jsonSchema, uiSchema){
  _reactDom.default.render(_react.default.createElement(CustomForm, {
    json_schema: jsonSchema,
    ui_schema: uiSchema
  }), document.getElementById(container));
}


var _default = CustomForm;
exports.default = _default;