module Support
  class Tools

    class << self

      def deep_hash_merge(existing_hash:, new_hash:)
        new_hash.each_pair do |current_key, new_value|
          existing_value = existing_hash[current_key]

          if existing_value.is_a?(Hash) && new_value.is_a?(Hash)
            existing_hash[current_key] = deep_hash_merge(existing_hash: existing_value, new_hash: new_value)
          elsif existing_value.is_a?(Array) && new_value.is_a?(Array)
            existing_hash[current_key] = (existing_value | new_value)
          else
            existing_hash[current_key] = new_value
          end
        end
        return existing_hash
      end

      def is_uuid?(value)
        !value.nil? &&  !(value =~ /[0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12}/i).nil?
      end
    end
  end
end
