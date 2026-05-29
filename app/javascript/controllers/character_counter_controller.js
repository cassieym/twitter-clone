import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "counter", "submit"]

  connect() {
    this.update()
  }

  update() {
    const remaining = 280 - this.inputTarget.value.length
    this.counterTarget.textContent = remaining

    this.counterTarget.classList.remove("text-zinc-500", "text-yellow-500", "text-red-500")
    if (remaining <= 0) {
      this.counterTarget.classList.add("text-red-500")
    } else if (remaining <= 20) {
      this.counterTarget.classList.add("text-yellow-500")
    } else {
      this.counterTarget.classList.add("text-zinc-500")
    }

    if (this.hasSubmitTarget) {
      this.submitTarget.disabled = remaining < 0 || this.inputTarget.value.trim().length === 0
    }
  }
}
