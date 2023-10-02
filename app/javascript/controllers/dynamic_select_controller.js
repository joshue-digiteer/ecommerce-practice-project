import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dynamic-select"
export default class extends Controller {
  static targets = ["select", "color", "size"]

  // For every time the HTML element/s that use this controller are rendered, initialize the action/s inside
  connect() {
    this.selected()
  }

  selected() {
    this.hideFields()

    switch (this.selectTarget.value) {
      case 'color_variant':
        this.colorTarget.classList.remove('hidden')
        this.colorTarget.querySelectorAll("input").forEach(
          function (input_field) {
            input_field.disabled = false;
          }
        )
        break;
      case 'size_variant':
        this.sizeTarget.classList.remove('hidden')
        this.sizeTarget.querySelectorAll("input").forEach(
          function (input_field) {
            input_field.disabled = false;
          }
        )
        break;
    }
  }

  hideFields() {
    this.colorTarget.classList.add('hidden')
    this.colorTarget.querySelectorAll("input").forEach(
      function (input_field) {
        input_field.disabled = true;
      }
    )

    this.sizeTarget.classList.add('hidden')
    this.sizeTarget.querySelectorAll("input").forEach(
      function (input_field) {
        input_field.disabled = true;
      }
    )
  }
}
