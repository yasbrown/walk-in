
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "time"]

  connect() {
  }

  show() {
    console.log("button");
    this.buttonTarget.classList.remove("hide")
  }

  active(e) {
    const timeSlots = document.querySelectorAll(".time-slot")
    timeSlots.forEach((timeSlot) => {
    timeSlot.classList.remove("active")})
    e.target.classList.toggle("active")
  }
}
