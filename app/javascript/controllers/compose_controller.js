import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "submit"]

  connect() {
    this.autoResize()
  }

  autoResize() {
    const input = this.inputTarget
    input.style.height = "auto"
    input.style.height = input.scrollHeight + "px"
  }

  reset() {
    this.inputTarget.value = ""
    this.inputTarget.style.height = "auto"
  }
}
