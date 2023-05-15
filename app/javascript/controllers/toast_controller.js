import { Controller } from "@hotwired/stimulus"
import { enter, leave } from "el-transition"

export default class extends Controller {
  static targets = ["notice"]

  connect() {
    enter(this.noticeTarget)

    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      leave(this.noticeTarget)
    }, 3000)
  }

  close(event) {
    leave(this.noticeTarget)
  }
}
