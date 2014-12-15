# encoding: UTF-8

require 'json/stream'
require 'rosette/core'

module Rosette
  module Extractors

    class JsonExtractor < Rosette::Core::StaticExtractor

      def extract_each_from(json_content)
        if block_given?
          parse(json_content) do |key_str, value_str|
            yield make_phrase(value_str, key_str)
          end
        else
          to_enum(__method__, json_content)
        end
      end

      def supports_line_numbers?
        false
      end

      protected

      def parse(json_content, &blk)
        parser = JSON::Stream::Parser.new.tap do |parser|
          parser.key { |key_str| key(key_str) }
          parser.value { |value_str| value(value_str, &blk) }
        end

        parser << json_content
      end

      class KeyValueExtractor < JsonExtractor
        protected

        def key(key_str)
          @key = key_str
        end

        def value(value_str)
          if block_given?
            yield @key, value_str
          end
        end
      end

    end
  end
end
