module Ngx
  module Config
    class Directive
      attr_accessor :name, :values, :children

      def initialize(name, values, children = [])
        @name = name
        @values = values
        @children = children
      end

      def value
        @values.first
      end

      def child
        @children.first
      end
    end
  end
end
