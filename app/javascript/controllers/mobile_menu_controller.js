import { Controller } from "@hotwired/stimulus"
import { enter, leave, toggle } from "el-transition"

export default class extends Controller {
  static targets = ["mobileMenu"]

  openMenu() {
    enter(this.mobileMenuTarget)
  }

  closeMenu() {
    enter(this.mobileMenuTarget)
  }

  toggleMenu() {
    toggle(this.mobileMenuTarget)
  }
}
