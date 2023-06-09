import { Controller } from "@hotwired/stimulus"
import { enter, leave, toggle } from "el-transition"

export default class extends Controller {
  static targets = ["menu"]

  openMenu() {
    enter(this.menuTarget)
  }

  closeMenu() {
    leave(this.menuTarget)
  }

  toggleMenu() {
    toggle(this.menuTarget)
  }
}
