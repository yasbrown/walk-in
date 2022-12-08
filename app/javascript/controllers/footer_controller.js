import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="footer"
export default class extends Controller {
  connect() {
    console.log("footer connexted!")
  }

  active(event) {
    // console.log(event)
    this.element.classList.toggle('.footer-icon-active');
    this.element.classList.toggle('');
  }
}
