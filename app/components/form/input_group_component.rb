# frozen_string_literal: true

module Form
  class InputGroupComponent < ViewComponent::Base
    def initialize(form:, attribute:)
      super
      @attribute = attribute
      @form = form
      @object = form.object
    end
  end
end
