require 'ngx/config/version'
require 'ngx/config/parser'
require 'ngx/config/transformer'
require 'ngx/config/node'

module Ngx
  module Config
    def self.parse(str)
      parser = Parser.new
      transformer = Transformer.new

      tree = parser.parse(str)
      root = Node.root(transformer.apply(tree))
      root
    end
  end
end
