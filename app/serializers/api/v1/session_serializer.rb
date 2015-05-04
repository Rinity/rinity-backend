module Api
  module V1
    # session_serializer.rb
    class SessionSerializer < Api::V1::BaseSerializer
      attributes :id, :email, :name, :admin, :token

      def token
        object.authentication_token
      end
    end
  end
end
