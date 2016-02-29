require 'parslet'

module Ngx
  module Config
    class Parser < Parslet::Parser
      rule(:spaces) { match('\s').repeat(1) }
      rule(:identifier) { match('[a-zA-Z0-9_]').repeat(1) }
      rule(:value) { match('[^\s;]').repeat(1) }
      rule(:directive) {
        identifier.as(:name) >> (spaces >> value.as(:value)).maybe >> str(';')
      }
      rule(:children) { directive.as(:directive).repeat }

      rule(:top) { children }
      root(:top)
    end
  end
end
