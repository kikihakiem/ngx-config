require 'parslet'

module Ngx
  module Config
    class Parser < Parslet::Parser
      rule(:spaces) { match('\s').repeat(1) }
      rule(:spaces?) { spaces.maybe }
      rule(:identifier) { match('[a-zA-Z0-9_]').repeat(1) }

      rule(:no_quote) { match('[^\s;]').repeat(1) }
      rule(:single_quoted) {
        str("'") >>
          (str('\\') >> any | str("'").absent? >> any).repeat.as(:string) >>
          str("'")
      }
      rule(:string) { single_quoted | no_quote }
      rule(:value) { string }

      rule(:directive) {
        spaces? >>
          identifier.as(:name) >>
          (spaces >> value.as(:value)).repeat(0).as(:values) >>
          str(';') >>
          spaces?
      }

      rule(:roots) { directive.as(:directive).repeat }
      root(:roots)
    end
  end
end
