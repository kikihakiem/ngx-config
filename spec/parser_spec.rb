require 'test_helper'

describe Ngx::Config do
  describe 'parse' do
    subject { Ngx::Config.parse(str) }

    describe 'when directive has no value' do
      let(:str) { 'foo;' }

      it 'returns directive with name only' do
        subject.size.must_equal 1
        subject.first.name.must_equal 'foo'
      end
    end

    describe 'when directive has value' do
      let(:str) { 'foo bar;' }

      it 'returns directive with name and value' do
        subject.first.name.must_equal 'foo'
        subject.first.value.must_equal 'bar'
      end
    end

    describe 'when directive has multiple values' do
      let(:str) { 'foo bar baz;' }

      it 'returns directive with array of values' do
        subject.first.values.size.must_equal 2
        subject.first.values.first.must_equal 'bar'
        subject.first.values.last.must_equal 'baz'
      end
    end
  end

end
