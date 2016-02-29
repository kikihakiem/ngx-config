require 'test_helper'

describe Ngx::Config do
  describe 'parse' do
    subject { Ngx::Config.parse(str) }

    describe 'when parse directive with no value' do
      let(:str) { 'foo;' }

      it 'returns child with its name' do
        subject.children.size.must_equal 1
        subject.children.first.name.must_equal 'foo'
      end
    end

    describe 'when parse directive with value' do
      let(:str) { 'foo bar;' }

      it 'returns child with its name and value' do
        subject.children.first.name.must_equal 'foo'
        subject.children.first.value.must_equal 'bar'
      end
    end
  end

end