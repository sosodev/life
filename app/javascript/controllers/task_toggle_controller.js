import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["children", "button"]

  toggle() {
    const childrenDiv = this.childrenTarget
    const toggleButton = this.buttonTarget
    
    if (childrenDiv.style.display === 'none' || childrenDiv.style.display === '') {
      childrenDiv.style.display = 'block'
      toggleButton.textContent = '▼'
    } else {
      childrenDiv.style.display = 'none'
      toggleButton.textContent = '▶'
    }
  }
}
