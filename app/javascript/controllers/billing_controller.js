import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["monthlyPlan", "yearlyPlan", "monthlyToggle", "yearlyToggle", "toggleContainer"]

  connect() {
    this.showMonthly()
  }

  toggle(event) {
    const isYearly = event.target.checked
    if (isYearly) {
      this.showYearly()
    } else {
      this.showMonthly()
    }
  }

  showMonthly() {
    this.monthlyPlanTarget.classList.remove("hidden")
    this.yearlyPlanTarget.classList.add("hidden")
    this.monthlyToggleTarget.classList.add("billing-label--active")
    this.yearlyToggleTarget.classList.remove("billing-label--active")
  }

  showYearly() {
    this.monthlyPlanTarget.classList.add("hidden")
    this.yearlyPlanTarget.classList.remove("hidden")
    this.monthlyToggleTarget.classList.remove("billing-label--active")
    this.yearlyToggleTarget.classList.add("billing-label--active")
  }
}
