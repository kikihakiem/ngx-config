require 'parslet'

module Ngx
  module Config
    class Parser < Parslet::Parser
      rule(:spaces) { match('\s').repeat(1) }
      rule(:spaces?) { spaces.maybe }
      rule(:identifier) { match('[a-zA-Z0-9_]').repeat(1) }

      rule(:value) { match('[^\s;]').repeat(1) }
      rule(:values) { (spaces >> value.as(:value)).repeat }
      rule(:directive) {
        spaces? >>
          identifier.as(:name) >>
          values.maybe.as(:values) >>
          str(';') >>
          spaces?
      }

      rule(:roots) { directive.as(:directive).repeat }
      root(:roots)
    end
  end
end
