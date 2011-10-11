require 'adapter'
require 'fog/aws/simpledb'

module Adapter
  module SimpleDB
    NonHashValueKeyName = '_value'
    ArrayFillName = '_array'

    def read(key)
      decode(client.get_attributes(domain, key_for(key), 'ConsistentRead' => options[:consistent_read]))
    end

    def write(key, value)
      encoded_value = encode(value)
      client.put_attributes(domain, key_for(key), encoded_value, :replace => encoded_value.keys)
    end

    def delete(key)
      read(key).tap { client.delete_attributes(domain, key_for(key)) }
    end

    def clear
      client.delete_domain(domain)
      client.create_domain(domain)
    end

    def encode(value)
      value = {NonHashValueKeyName => value} unless value.is_a?(Hash)
      value.each {|key, v| v.unshift(ArrayFillName) if v.is_a?(Array) }
    end

    def decode(value)
      value = value.body['Attributes']
      return if value.nil? || value == {}
      value = fix_arrays(value)
      value.key?(NonHashValueKeyName) ? value[NonHashValueKeyName] : value
    end

    private
      def domain
        options[:domain] || raise('no :domain specified')
      end

      def fix_arrays(hash)
        hash.each do |key, value|
          if value.first == ArrayFillName
            value.shift
          else
            hash[key] = value.first
          end
        end
      end
  end
end

Adapter.define(:simpledb, Adapter::SimpleDB)