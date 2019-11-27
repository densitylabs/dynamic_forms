"use strict";

function _instanceof(left, right) { if (right != null && typeof Symbol !== "undefined" && right[Symbol.hasInstance]) { return !!right[Symbol.hasInstance](left); } else { return left instanceof right; } }

function _typeof(obj) { if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!_instanceof(instance, Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

function FormPreview(props) {
  var Form = JSONSchemaForm.default;
  return React.createElement("div", null, React.createElement(Form, {
    schema: props.jsonSchema,
    uiSchema: props.uiSchema,
    field: JSONSchemaForm.default
  }));
}

function jsonSchema() {
  var jsonSchemaField = document.getElementById("custom_form_json_schema");
  return JSON.parse(jsonSchemaField.value);
}

function uiSchema() {
  var uiSchemaField = document.getElementById("custom_form_ui_schema");
  return JSON.parse(uiSchemaField.value);
}

var App =
/*#__PURE__*/
function (_React$Component) {
  _inherits(App, _React$Component);

  function App(props) {
    var _this;

    _classCallCheck(this, App);

    _this = _possibleConstructorReturn(this, _getPrototypeOf(App).call(this, props));
    _this.state = {
      json_schema: jsonSchema(),
      ui_schema: uiSchema()
    };
    _this.showPreview = _this.showPreview.bind(_assertThisInitialized(_this));
    return _this;
  }

  _createClass(App, [{
    key: "showPreview",
    value: function showPreview(e) {
      e.preventDefault();
      this.setState({
        json_schema: jsonSchema(),
        ui_schema: uiSchema()
      });
    }
  }, {
    key: "render",
    value: function render() {
      return React.createElement("div", null, React.createElement("div", {
        className: "row"
      }, React.createElement("div", {
        className: "col-md-12"
      }, React.createElement("div", {
        className: "d-flex justify-content-between"
      }, React.createElement("h3", null, "Preview"), React.createElement("button", {
        className: "btn btn-link",
        onClick: this.showPreview
      }, "Refresh preview")))), React.createElement(FormPreview, {
        jsonSchema: this.state.json_schema,
        uiSchema: this.state.ui_schema
      }));
    }
  }]);

  return App;
}(React.Component);

ReactDOM.render(React.createElement(App, null), document.getElementById('form_preview'));
