require 'ngx/config/version'
require 'ngx/config/parser'
require 'ngx/config/transformer'

module Ngx
  module Config
    def self.parse(str)
      parser = Parser.new
      transformer = Transformer.new

      tree = parser.parse(str)
      transformer.apply(tree)
    end
  end
end
