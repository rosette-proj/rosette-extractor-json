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

      class KeyValueExtractor < JsonExtractor
        protected

        def parse(json_content, &blk)
          open_obj_count = 0
          open_array_count = 0
          key = nil

          parser = JSON::Stream::Parser.new.tap do |parser|
            parser.key { |key_str| key = key_str }

            parser.value do |value_str|
              if block_given? && open_array_count.zero? && open_obj_count == 1
                yield key, value_str
              end
            end

            parser.start_object { open_obj_count += 1 }
            parser.end_object { open_obj_count -= 1 }
            parser.start_array { open_array_count += 1 }
            parser.end_array { open_array_count -= 1 }
          end

          parser << json_content
        rescue JSON::Stream::ParserError => e
          raise Rosette::Core::SyntaxError.new('syntax error', e, :json)
        end

      end
    end
  end
end
