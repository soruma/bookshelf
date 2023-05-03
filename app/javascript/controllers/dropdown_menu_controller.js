import { Controller } from "@hotwired/stimulus"
import { enter, leave, toggle } from "el-transition"

export default class extends Controller {
  static targets = ["menu", "mobileMenu"]

  openMenu() {
    enter(this.menuTarget)
    enter(this.mobileMenuTarget)
  }

  closeMenu() {
    enter(this.menuTarget)
    enter(this.mobileMenuTarget)
  }

  toggleMenu() {
    toggle(this.menuTarget)
    toggle(this.mobileMenuTarget)
  }
}
