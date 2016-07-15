module Moorkit
  module UserAuthentication
    module Entity
      class AuthPayload

        attr_reader :uid,
                    :provider,
                    :email,
                    :first_name,
                    :last_name,
                    :data,
                    :token,
                    :expires_at

        def initialize(attribs)
          attribs.each { |k,v| instance_variable_set("@#{k}",v) unless v.nil? }
        end

        def to_hash
          hash = {}
          instance_variables.each { |v| hash[v.to_s.delete("@")] = instance_variable_get(v) }
          hash
        end
      end
    end
  end
end
