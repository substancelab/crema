# frozen_string_literal: true

module Flowbite
  # Renders a HTML button element.
  #
  # See https://flowbite.com/docs/components/buttons/
  #
  # @param label [String] The text to display on the button.
  # @param type [Symbol] The type of the button. Default is :button.
  class Button < ViewComponent::Base
    attr_reader :label, :type

    def initialize(label:, type: :button)
      super
      @label = label
      @type = type
    end

    def call
      content_tag(
        :button,
        label,
        :class => classes
      )
    end

    private

    def classes
      [
        "text-white",
        "bg-blue-700",
        "hover:bg-blue-800",
        "focus:ring-4",
        "focus:ring-blue-300",
        "font-medium",
        "rounded-lg",
        "text-sm",
        "px-5",
        "py-2.5",
        "me-2",
        "mb-2",
        "dark:bg-blue-600",
        "dark:hover:bg-blue-700",
        "focus:outline-none",
        "dark:focus:ring-blue-800",
      ]
    end
  end
end
