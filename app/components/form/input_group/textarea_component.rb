# frozen_string_literal: true

module Form
  module InputGroup
    class TextareaComponent < Form::InputGroup::Component
      # Returns the HTML to use for the actual input field element.
      def input_field
        render(::Flowbite::Input::Textarea.new(@form, @attribute))
      end
    end
  end
end
