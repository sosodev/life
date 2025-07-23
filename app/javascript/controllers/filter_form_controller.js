import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form"]

  change() {
    const params = new URLSearchParams()
    const formData = new FormData(this.formTarget)

    for (const [key, value] of formData.entries()) {
      if (value) {
        params.append(key, value)
      }
    }

    const queryString = params.toString()
    const url = `${this.formTarget.action}${queryString ? `?${queryString}` : ''}`

    Turbo.visit(url)
  }
}
