# frozen_string_literal: true

module Form
  module InputGroup
    class EmailComponent < Form::InputGroup::Component
      def input_field_class
        ::Flowbite::Input::Email
      end
    end
  end
end
