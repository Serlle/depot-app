import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="payment"
export default class extends Controller {
  static targets = [ "selection", "additionalFields" ]

  initialize() {
    this.showAdditionalFields()
  }

  showAdditionalFields() {
    // Retrieve the name (text) of the currently selected ID payment_type from the dropdown,
    // and remove any leading or trailing spaces to match it with the corresponding fieldset.
    let selectedName = this.selectionTarget.options[this.selectionTarget.selectedIndex].text.trim()

    for (let fields of this.additionalFieldsTargets) {
      fields.disabled = fields.hidden = (fields.dataset.type != selectedName)
    }
  }
}
