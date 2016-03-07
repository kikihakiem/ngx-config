require 'test_helper'

describe Ngx::Config do
  describe 'parse' do
    subject { Ngx::Config.parse(str) }

    describe 'when directive has value' do
      let(:str) { 'pid /run/nginx.pid;' }

      it 'returns directive with name and value' do
        subject.first.name.must_equal 'pid'
        subject.first.value.must_equal '/run/nginx.pid'
      end
    end

    describe 'when directive has multiple values' do
      let(:str) { 'server_name example.com *.example.com;' }

      it 'returns directive with all the values' do
        subject.first.values.size.must_equal 2
        subject.first.values.first.must_equal 'example.com'
        subject.first.values.last.must_equal '*.example.com'
      end

      describe 'when values separated by line breaks' do
        let(:str) {
          %{
            server_name example.com
              *.example.com;
          }
        }

        it 'returns directive with all the values' do
          subject.first.values.size.must_equal 2
          subject.first.values.first.must_equal 'example.com'
          subject.first.values.last.must_equal '*.example.com'
        end
      end
    end

    describe 'when value has special char' do
      let(:str) { 'server_name ~^(www|blog).*\\.example\\.com$;' }

      it 'returns directive with value correctly' do
        subject.first.value.must_equal '~^(www|blog).*\\.example\\.com$'
      end
    end

    describe 'when values is a quoted string' do
      describe 'when value is single-quoted string' do
        let(:str) { "lua_package_path '/foo/bar/?.lua;/blah/?.lua;;';" }

        it 'returns directive with value' do
          subject.first.values.size.must_equal 1
          subject.first.value.must_equal '/foo/bar/?.lua;/blah/?.lua;;'
        end
      end

      describe 'when value is double-quoted string' do
        let(:str) { 'default_type "text/plain";' }

        it 'returns directive with value' do
          subject.first.values.size.must_equal 1
          subject.first.value.must_equal 'text/plain'
        end
      end

      describe 'when theres escaped quote' do
        let(:str) { "set_by_lua $var 'return \\'foo\\'';" }

        it 'returns directive with value' do
          subject.first.values.size.must_equal 2
          subject.first.values.last.must_equal "return \\'foo\\'"
        end
      end

      describe 'when theres double-quote char in single-quoted string' do
        let(:str) { "set_by_lua $var 'return \"foo\"';" }

        it 'returns directive with value' do
          subject.first.values.size.must_equal 2
          subject.first.values.last.must_equal 'return "foo"'
        end
      end

      describe 'when there are multiple strings' do
        let(:str) { 'try_files "/etc/nginx/default.html" \'/etc/nginx/index.html\';' }

        it 'returns directive with all the values' do
          subject.first.values.size.must_equal 2
          subject.first.values.first.must_equal '/etc/nginx/default.html'
          subject.first.values.last.must_equal '/etc/nginx/index.html'
        end
      end

      describe 'when theres multi-line string' do
        let(:str) {
          %{
            content_by_lua '
              ngx.say("Hello, world!")
            ';
          }
        }

        it 'returns string value correctly' do
          subject.first.value.must_equal %{
              ngx.say("Hello, world!")
            }
        end
      end
    end

    describe 'when there are multiple directives' do
      describe 'on different lines' do
        let(:str) {
          %{
            client_max_body_size 50k;
            client_body_buffer_size 50k;
          }
        }

        it 'returns directives' do
          subject.size.must_equal 2
          subject.last.name.must_equal 'client_body_buffer_size'
          subject.last.value.must_equal '50k'
        end
      end

      describe 'on same line' do
        let(:str) { 'listen 80; server_name example.com;' }

        it 'returns directives' do
          subject.size.must_equal 2
          subject.last.name.must_equal 'server_name'
          subject.last.value.must_equal 'example.com'
        end
      end
    end

    describe 'when theres nested directive' do
      let(:str) {
        %[
          location = /lua {
            content_by_lua_file /etc/nginx/handler.lua;
          }
        ]
      }

      it 'returns parent directive' do
        subject.first.name.must_equal 'location'
        subject.first.values.first.must_equal '='
        subject.first.values.last.must_equal '/lua'
      end

      it 'returns child directive' do
        subject.first.children.size.must_equal 1
        subject.first.child.name.must_equal 'content_by_lua_file'
        subject.first.child.value.must_equal '/etc/nginx/handler.lua'
      end
    end
  end

end
