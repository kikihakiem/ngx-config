module Ngx
  module Config
    class Directive
      attr_accessor :name, :value

      def initialize(name, value = nil)
        @name = name
        @value = value
      end
    end
  end
end
