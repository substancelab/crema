# frozen_string_literal: true

module Form
  module InputGroup
    class TextareaComponent < Form::InputGroup::Component
      def input_field_class
        ::Flowbite::Input::Textarea
      end
    end
  end
end
