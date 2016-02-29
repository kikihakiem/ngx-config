require 'parslet'
require_relative 'node'

module Ngx
  module Config
    class Transformer < Parslet::Transform
      rule(directive: { name: simple(:name) }) {
        Node.new(name, nil)
      }
      rule(directive: { name: simple(:name), value: simple(:value) }) {
        Node.new(name, value)
      }
    end
  end
end