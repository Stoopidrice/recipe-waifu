import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.scrollToBottom()
  }

  // Runs whenever a new message element is injected into the DOM
  messageAdded() {
    requestAnimationFrame(() => this.scrollToBottom())
  }

  scrollToBottom() {
    window.scrollTo({
      top: document.documentElement.scrollHeight,
      behavior: "smooth"
    })
  }
}
