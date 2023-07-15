# frozen_string_literal: true

class ModalBuilder
  attr_reader :modal

  def self.build
    builder = new
    yield(builder)
    builder.modal
  end

  def initialize
    @modal = Modal.new
  end

  def title(title)
    @modal.title = title
  end

  def submit(submit)
    @modal.submit = submit
  end

  def cancel(cancel)
    @modal.cancel = cancel
  end
end
