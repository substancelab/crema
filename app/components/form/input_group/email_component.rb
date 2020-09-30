# frozen_string_literal: true

module Form
  module InputGroup
    class EmailComponent < Form::InputGroup::Component
      # Returns the name of the method used to generate HTML for the input field
      def input_field_type
        :email_field
      end
    end
  end
end
