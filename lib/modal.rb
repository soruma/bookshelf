# frozen_string_literal: true

class Modal
  attr_accessor :title, :submit, :cancel

  class Operation
    attr_accessor :name, :href

    def initialize(name, href)
      @name = name
      @href = href
    end
  end
end
