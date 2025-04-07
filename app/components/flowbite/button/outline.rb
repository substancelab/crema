# frozen_string_literal: true

module Flowbite
  class Button
    class Outline < Flowbite::Button
      class << self
        def default_classes
          [
            "text-blue-700",
            "hover:text-white",
            "border",
            "border-blue-700",
            "hover:bg-blue-800",
            "focus:ring-4",
            "focus:outline-none",
            "focus:ring-blue-300",
            "font-medium",
            "rounded-lg",
            "text-sm",
            "px-5",
            "py-2.5",
            "text-center",
            "me-2",
            "mb-2",
            "dark:border-blue-500",
            "dark:text-blue-500",
            "dark:hover:text-white",
            "dark:hover:bg-blue-500",
            "dark:focus:ring-blue-800",
          ]
        end
      end

      private

      def classes
        self.class.default_classes
      end
    end
  end
end
