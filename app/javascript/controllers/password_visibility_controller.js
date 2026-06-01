import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "input", "icon" ]
  connect() {
    // Ensure icon is initialized when controller connects
    this.updateIcon(false)
  }

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
    const name = visible ? "eye-off" : "eye"

    // If lucide provides direct SVG generation, use it for a reliable replacement
    if (window.lucide && window.lucide.icons && window.lucide.icons[name] && typeof window.lucide.icons[name].toSvg === 'function') {
      try {
        this.iconTarget.innerHTML = window.lucide.icons[name].toSvg({ width: 20, height: 20 })
        return
      } catch (e) {
        // fall through to fallback
      }
    }

    // Fallback: insert data-lucide markup and ask lucide to replace it
    this.iconTarget.innerHTML = `<i data-lucide="${name}"></i>`
    if (window.lucide && typeof window.lucide.createIcons === 'function') {
      window.lucide.createIcons()
    }
  }
}
