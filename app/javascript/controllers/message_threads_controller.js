import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="message-threads"
export default class extends Controller {
  connect() {
    this.element.addEventListener('click', (e) => {
      Turbo.visit(this.element.dataset.messageUrl);
    });
  }
}
