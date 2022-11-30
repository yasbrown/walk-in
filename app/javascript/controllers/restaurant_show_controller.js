
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button"]

  connect() {
  }

  show() {
    console.log("button");
    this.buttonTarget.classList.remove("hide")
  }
}
