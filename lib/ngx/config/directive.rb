module Ngx
  module Config
    class Directive
      attr_accessor :name, :values

      def initialize(name, values = nil)
        @name = name
        @values = values
      end

      def value
        @values.first
      end
    end
  end
end
