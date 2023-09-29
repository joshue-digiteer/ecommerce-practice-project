import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="turbo-modal"
export default class extends Controller {
  static targets = ["modal"]

  hideModal() {
    this.element.parentElement.removeAttribute("src") // it might be nice to also remove the modal's src
    this.element.remove()
  }

  // Hide modal on successful form submission
  submitEnd(e) {
    if (e.detail.success) {
      this.hideModal()
    }
  }

  // Hide modal when pressing ESC
  closeWithKeyboard(e) {
    if (e.code == "Escape") {
      this.hideModal()
    }
  }

  // Hide modal when clicking outside of modal
  closeBackground(e) {
    if (e && this.modalTarget.contains(e.target)) {
      return;
    }
    this.hideModal();
  }
}
