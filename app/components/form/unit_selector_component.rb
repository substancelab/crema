# frozen_string_literal: true

module Form
  class UnitSelectorComponent < Flowbite::InputField::Select
    def initialize(form:, attribute:)
      super(
        :form => form,
        :attribute => attribute,
        :collection => collection
      )
    end

    private

    def collection
      Service::UNITS.sort
    end
  end
end
