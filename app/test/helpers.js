(function () {

  function Helpers(querySelector) {
    this.el = document.querySelector(querySelector);
    if (!this.el) {
      throw 'No element found for test query selector: ' + querySelector;
    }
  };
  Helpers.prototype.expectCount = function (count, selector) {
    assert.equal(count, this.el.shadowRoot.querySelectorAll(selector).length);
  };
  Helpers.prototype.expectAttribute = function (attribute, value) {

  };
  window.Helpers = Helpers;
}());
