import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.scrollToBottom()
  }

  // Triggers whenever a new message element is injected into the DOM
  messageAdded() {
    this.scrollToBottom()
  }

  scrollToBottom() {
    window.scrollTo({
      top: document.body.scrollHeight,
      behavior: "smooth" // Change to "smooth" if you want an animated scroll
    })
  }
}
