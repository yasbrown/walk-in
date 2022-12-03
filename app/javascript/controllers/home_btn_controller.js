import { Controller } from "@hotwired/stimulus"
// import ScrollTo from 'stimulus-scroll-to'

// const application = Application.start()
// application.register('scroll-to', ScrollTo)

// Connects to data-controller="home-btn"
export default class extends Controller {
  static targets = ['btn.push']

  connect() {
    console.log("connected")
  }

  scroll(event) {
    console.log(this.Element)

    event.preventDefault()
    event.window.scrollBy(0, 852)
  }

}
