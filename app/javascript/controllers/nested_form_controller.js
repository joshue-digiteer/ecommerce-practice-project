import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="nested-form"
export default class extends Controller {
  // Used for setting data-target (refer to the ProductVariant nested form in products/index.html.slim)
  static targets = ["add_product_variant", "template"]

  add_association(e) {
    // Prevents the event's default action from happening
    // e.g. preventing the submit button from submitting a form
    e.preventDefault()

    // templateTarget are objects created by StimulusJS through "static targets"

    // TEMPLATE_RECORD is the value of child_index in the template part of the ProductVariant nested form (refer to products/index.html.slim)
    let content = this.templateTarget.innerHTML.replace(/PRODUCT_VARIANT_RECORD/g, new Date().valueOf())

    // beforebegin adds the HTML code above the caller (Add Product Variant link_to)
    this.add_product_variantTarget.insertAdjacentHTML('beforebegin', content)
  }

  remove_association(e) {
    e.preventDefault()

    let item = e.target.closest(".variant-fields")
    item.querySelector("input[name*='_destroy']").value = 1
    item.style.display = 'none'
  }

}
