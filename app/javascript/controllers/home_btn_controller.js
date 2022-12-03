import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="home-btn"
export default class extends Controller {
  static targets = ['btn.push']

  connect() {
    console.log("connected")
  }

  push() {
    console.log(this.btn.pushTarget)
    // document.querySelector('.form').scrollIntoView({
    //   behavior: 'smooth'
    // });
  }

}

// document.querySelector("#home-btn").addEventListener("click", funcyi)
