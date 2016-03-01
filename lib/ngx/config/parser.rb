require 'parslet'

module Ngx
  module Config
    class Parser < Parslet::Parser
      rule(:spaces) { match('\s').repeat(1) }
      rule(:identifier) { match('[a-zA-Z0-9_]').repeat(1) }

      rule(:value) { match('[^\s;]').repeat(1) }
      rule(:values) { (spaces >> value.as(:value)).repeat }
      rule(:directive) {
        identifier.as(:name) >>
          values.maybe.as(:values) >>
          str(';')
      }

      rule(:roots) { directive.as(:directive).repeat }
      root(:roots)
    end
  end
end
