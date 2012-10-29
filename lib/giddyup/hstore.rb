require 'active_record/connection_adapters/postgresql_adapter'
# activerecord-postgres-hstore expects you want Rails.
# active_record_hstore_serializer adds methods to String and Hash,
# which is unnecessary.
module HstoreSerializer
  extend self

  def load(text)
    return text if Hash === text
    return {} if text.nil?
    raise ArgumentError unless String === text
    from_hstore(text)
  end

  def dump(value)
    return value if String === value
    value = {} if value.nil?
    raise ArgumentError unless Hash === value
    to_hstore(value)
  end

  def valid?(value)
    Hash === value || value =~ VALID_HSTORE
  end

  private
  # We don't need to make a new Regexp everytime just to match this,
  # so it's a constant.
  HSTORE_PAIR = begin
                  quoted_string = /"[^"\\]*(?:\\.[^"\\]*)*"/
                  unquoted_string = /[^\s=,][^\s=,\\]*(?:\\.[^\s=,\\]*|=[^,>])*/
                  string = /(#{quoted_string}|#{unquoted_string})/
                  /#{string}\s*=>\s*#{string}/
                end

  # Copied, but seemingly unused
  VALID_HSTORE = /^\s*(#{HSTORE_PAIR}\s*(,\s*#{HSTORE_PAIR})*)?\s*$/

  # Creates a hash from a valid double quoted hstore format, 'cause this is the format
  # that postgresql spits out.
  def from_hstore(text)
    token_pairs = (text.scan(HSTORE_PAIR)).map { |k,v| [k,v =~ /^NULL$/i ? nil : v] }
    token_pairs = token_pairs.map { |k,v|
      [k,v].map { |t|
        case t
        when nil then t
        when /^"(.*)"$/ then $1.gsub(/\\(.)/, '\1')
        else t.gsub(/\\(.)/, '\1')
        end
      }
    }
    Hash[ token_pairs ]
  end

  def to_hstore(hash)
    return "" if hash.empty?

    hash.map { |idx, val|
      iv = [idx,val].map { |_|
        e = _.to_s.gsub(/"/, '\"')
        if _.nil?
          'NULL'
        elsif e =~ /[,\s=>]/ || e.blank?
          '"%s"' % e
        else
          e
        end
      }

      "%s=>%s" % iv
    } * ","
  end
end


module ActiveRecord
  # This erro class is used when the user passes a wrong value to a hstore column.
  # Hstore columns accepts hashes or hstore valid strings. It is validated with
  # String#valid_hstore? method.
  class HstoreTypeMismatch < ActiveRecord::ActiveRecordError
  end

  module ConnectionAdapters

    class TableDefinition

      # Adds hstore type for migrations. So you can add columns to a table like:
      #   create_table :people do |t|
      #     ...
      #     t.hstore :info
      #     ...
      #   end
      def hstore(*args)
        options = args.extract_options!
        column_names = args
        column_names.each { |name| column(name, 'hstore', options) }
      end

    end

    class Table

      # Adds hstore type for migrations. So you can add columns to a table like:
      #   change_table :people do |t|
      #     ...
      #     t.hstore :info
      #     ...
      #   end
      def hstore(*args)
        options = args.extract_options!
        column_names = args
        column_names.each { |name| column(name, 'hstore', options) }
      end

    end
    
    class PostgreSQLColumn < Column
      # Does the type casting from hstore columns using String#from_hstore or Hash#from_hstore.
      def type_cast_code_with_hstore(var_name)
        type == :hstore ? "HstoreSerializer.load(#{var_name})" : type_cast_code_without_hstore(var_name)
      end

      # Adds the hstore type for the column.
      def simplified_type_with_hstore(field_type)
        field_type == 'hstore' ? :hstore : simplified_type_without_hstore(field_type)
      end

      alias_method_chain :type_cast_code, :hstore
      alias_method_chain :simplified_type, :hstore
    end

    class PostgreSQLAdapter < AbstractAdapter
      NATIVE_DATABASE_TYPES[:hstore] = {:name => "hstore"} unless NATIVE_DATABASE_TYPES.include?(:hstore)
      
      # Quotes correctly a hstore column value.
      def quote_with_hstore(value, column = nil)
        if value && column && column.sql_type == 'hstore'
          raise HstoreTypeMismatch, "#{column.name} must have a Hash or a valid hstore value (#{value})" unless HstoreSerializer.valid?(value)
          return quote_without_hstore(HstoreSerializer.dump(value), column)
        end
        quote_without_hstore(value,column)
      end

      alias_method_chain :quote, :hstore
    end
  end
end
