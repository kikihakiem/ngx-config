module Ngx
  module Config
    class Node
      attr_accessor :name, :value, :parent, :children

      def initialize(name, value)
        @name = name
        @value = value
      end

      def self.root(children)
        root = new(nil, nil)
        root.children = children
        root
      end
    end
  end
end
