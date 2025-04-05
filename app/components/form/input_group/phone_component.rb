# frozen_string_literal: true

module Form
  module InputGroup
    class PhoneComponent < Form::InputGroup::Component
      def input_field_class
        ::Flowbite::Input::Phone
      end
    end
  end
end
