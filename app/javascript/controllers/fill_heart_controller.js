import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="fill-heart"
export default class extends Controller {
  static targets = [ "icon" ]
  connect() {
    console.log("hello hello");
    console.log(this.element);
  }

  animation(event) {
    this.element.classList.toggle('fa-solid');
    this.element.classList.toggle('fa-regular');

    this.element.classList.toggle('animating-heart');
  }
}
