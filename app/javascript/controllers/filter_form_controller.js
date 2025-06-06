import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form"]

  change() {
    this.formTarget.requestSubmit()
  }
}
