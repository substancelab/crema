# frozen_string_literal: true

module Form
  module InputGroup
    class NumberComponent < Form::InputGroup::Component
      def input_field_class
        ::Flowbite::Input::Number
      end
    end
  end
end
