require 'parslet'
require_relative 'directive'

module Ngx
  module Config
    class Transformer < Parslet::Transform
      rule(directive: { name: simple(:name) }) {
        Directive.new(name)
      }
      rule(directive: { name: simple(:name), value: simple(:value) }) {
        Directive.new(name, value)
      }
    end
  end
end