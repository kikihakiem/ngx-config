require 'parslet'
require_relative 'directive'

module Ngx
  module Config
    class Transformer < Parslet::Transform
      rule(directive: { name: simple(:name), values: subtree(:values) }) {
        Directive.new(name, values)
      }
      rule(directive: { name: simple(:name), values: subtree(:values), children: subtree(:children) }) {
        Directive.new(name, values, children)
      }
      rule(string: simple(:string)) { string.to_s }
      rule(value: simple(:value)) { value }
    end
  end
end