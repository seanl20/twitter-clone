import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="messages"
export default class extends Controller {
  static targets = ['messageThread']

  headers = { 'Accept': 'text/vnd.turbo-stream.html'}

  connect() {
    this.messageThreadTargets.forEach((messageThread) => {
      messageThread.addEventListener('click', (e) => {
        e.preventDefault();

        fetch(`/messages/${messageThread.dataset.messageThreadId}/messages`, {headers: this.headers})
          .then(response => response.text())
          .then(html => Turbo.renderStreamMessage(html));
      })
    })
  }
}
