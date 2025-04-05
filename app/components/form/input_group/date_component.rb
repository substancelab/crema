# frozen_string_literal: true

module Form
  module InputGroup
    class DateComponent < Form::InputGroup::Component
      def input_field_class
        ::Flowbite::Input::Date
      end
    end
  end
end
