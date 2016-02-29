require 'parslet'
require_relative 'node'

module Ngx
  module Config
    class Transformer < Parslet::Transform
      rule(node: { name: simple(:name), value: simple(:value) }) do
        Node.new(name, value)
      end
    end
  end
end