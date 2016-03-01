require 'parslet'
require_relative 'directive'

module Ngx
  module Config
    class Transformer < Parslet::Transform
      rule(directive: { name: simple(:name) }) {
        Directive.new(name)
      }
      rule(directive: { name: simple(:name), values: subtree(:values) }) {
        Directive.new(name, values)
      }
      rule(value: simple(:value)) { value.to_s }
      rule(values: subtree(:values)) {
        values.is_a?(Array) ? values : [values]
      }
    end
  end
end