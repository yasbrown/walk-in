
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "time"]

  connect() {
  }

  show() {
    console.log("button");
    this.buttonTarget.classList.remove("hide")
  }

  active() {
    this.timeTarget.classList.add("active")
  }
}
