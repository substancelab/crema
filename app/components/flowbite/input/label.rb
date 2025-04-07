# frozen_string_literal: true

module Flowbite
  module Input
    class Label < ViewComponent::Base
      class << self
        def default_classes
          [
            "block",
            "mb-2",
            "text-sm",
            "font-medium",
            "text-gray-900",
            "dark:text-white",
          ]
        end

        def error_classes
          [
            "block",
            "mb-2",
            "text-sm",
            "font-medium",
            "text-red-700",
            "dark:text-red-500",
          ]
        end
      end

      STATES = [
        DEFAULT = :default,
        ERROR = :error,
      ].freeze

      def call
        @form.label(
          @attribute,
          :class => label_classes
        )
      end

      def errors?
        @object.errors.include?(@attribute.intern)
      end

      def initialize(form, attribute)
        super
        @attribute = attribute
        @form = form
        @object = form.object
      end

      # Returns an array with the CSS classes to apply to the label element
      def label_classes
        case state
        when ERROR
          self.class.error_classes
        else
          self.class.default_classes
        end
      end

      protected

      # Returns the state of the label.
      #
      # See the STATES constant for valid values.
      #
      # @return [Symbol] the state of the label
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
