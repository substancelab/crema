# frozen_string_literal: true

module Form
  class UnitSelectorComponent < Form::InputGroup::SelectComponent
    def initialize(form:, attribute:)
      super(
        :form => form,
        :attribute => attribute,
        :collection => collection
      )
    end

    private

    def collection
      Service::UNITS
    end
  end
end
