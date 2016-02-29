require 'parslet'

module Ngx
  module Config
    class Parser < Parslet::Parser
      rule(:identifier) { match('[a-zA-Z0-9_]').repeat(1) }
      rule(:node) {
        identifier.as(:name) >> str(';')
      }
      rule(:children) { node.as(:node).repeat }

      rule(:top) { children }
      root(:top)
    end
  end
end
