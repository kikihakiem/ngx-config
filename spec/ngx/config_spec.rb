require 'test_helper'

class Ngx::ConfigTest < Minitest::Test
  context 'config' do
    should 'have a version number' do
      refute_nil ::Ngx::Config::VERSION
    end
  end
end
