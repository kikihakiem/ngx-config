require 'parslet'

module Ngx
  module Config
    class Parser < Parslet::Parser
      rule(:spaces) { match('\s').repeat(1) }
      rule(:spaces?) { spaces.maybe }
      rule(:identifier) { match('[a-zA-Z0-9_]').repeat(1) }

      rule(:no_quote) { match('[^\s\;\{\}]').repeat(1) }
      rule(:single_quoted) {
        str("'") >>
          (str('\\') >> any | str("'").absent? >> any).repeat.as(:string) >>
          str("'")
      }
      rule(:double_quoted) {
        str('"') >>
          (str('\\') >> any | str('"').absent? >> any).repeat.as(:string) >>
          str('"')
      }
      rule(:string) { single_quoted | double_quoted | no_quote }

      rule(:value) { string }
      rule(:values) { (spaces >> value.as(:value)).repeat(1) }

      rule(:block) {
        str('{') >> directives.as(:children).maybe >> str('}')
      }

      rule(:directive) {
        identifier.as(:name) >>
          values.as(:values) >>
          (spaces? >> block | str(';'))
      }
      rule(:directives) {
        (spaces? >> directive.as(:directive)).repeat >>
          spaces?
      }

      rule(:roots) { directives.maybe }
      root(:roots)
    end
  end
end
