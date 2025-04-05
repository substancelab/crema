# frozen_string_literal: true

module Flowbite
  module Input
    class Field < ViewComponent::Base
      STATES = [
        DEFAULT = :default,
        ERROR = :error,
      ].freeze

      def initialize(form, attribute)
        super
        @attribute = attribute
        @form = form
        @object = form.object
      end

      # Returns the HTML to use for the actual input field element.
      def call
        @form.send(
          input_field_type,
          @attribute,
          :class => input_field_classes
        )
      end

      # Returns an array with the CSS classes to apply to the input field
      def input_field_classes
        case state
        when ERROR
          error_classes
        else
          default_classes
        end
      end

      # Returns the name of the method used to generate HTML for the input field
      def input_field_type
        :text_field
      end

      protected

      def errors?
        @object.errors.include?(@attribute.intern)
      end

      private

      def default_classes
        [
          "bg-gray-50",
          "border",
          "border-gray-300",
          "text-gray-900",
          "text-sm",
          "rounded-lg",
          "focus:ring-blue-500",
          "focus:border-blue-500",
          "block",
          "w-full",
          "p-2.5",
          "dark:bg-gray-700",
          "dark:border-gray-600",
          "dark:placeholder-gray-400",
          "dark:text-white",
          "dark:focus:ring-blue-500",
          "dark:focus:border-blue-500",
        ]
      end

      def error_classes
        [
          "bg-red-50",
          "border",
          "border-red-500",
          "text-red-900",
          "placeholder-red-700",
          "text-sm",
          "rounded-lg",
          "focus:ring-red-500",
          "dark:bg-gray-700",
          "focus:border-red-500",
          "block",
          "w-full",
          "p-2.5",
          "dark:text-red-500",
          "dark:placeholder-red-500",
          "dark:border-red-500",
        ]
      end

      def state
        if errors?
          ERROR
        else
          DEFAULT
        end
      end
    end
  end
end
