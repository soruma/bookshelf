import { Controller } from "@hotwired/stimulus"
import { enter, leave, toggle } from "el-transition"

export default class extends Controller {
  static targets = ["backdrop", "modal"]

  connect() {
    enter(this.backdropTarget)
    enter(this.modalTarget)
  }

  close(event) {
    if (event.detail.success) {
      leave(this.backdropTarget)
      leave(this.modalTarget)
    }
  }

  cancel() {
    leave(this.backdropTarget)
    leave(this.modalTarget)
  }
}
