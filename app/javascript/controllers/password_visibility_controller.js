import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "input", "icon" ]

  toggle() {
    if (this.inputTarget.type === "password") {
      this.inputTarget.type = "text"
      this.updateIcon(true)
    } else {
      this.inputTarget.type = "password"
      this.updateIcon(false)
    }
  }

  updateIcon(visible) {
    if (visible) {
      this.iconTarget.innerHTML = `<i data-lucide="eye-off"></i>`
    } else {
      this.iconTarget.innerHTML = `<i data-lucide="eye"></i>`
    }
    if (window.lucide) {
      window.lucide.createIcons();
    }
  }
}
