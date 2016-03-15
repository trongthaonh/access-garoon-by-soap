module Garoon
  class Client
    attr_reader :bulletin

    def initialize(savon)
      @savon = savon
      @bulletin = Bulletin.new(self)
      # Todo: Instead of logging in here, receive a session cookie from the VPN server when a VPN connection is established.
      login
    end

    def create_operation(type, action)
      operation = @savon.operation(type.to_s + 'Service', type.to_s + 'Port', action)

      operation.custom_header = {
        Action: action,
        Timestamp: {
          Created: '2017-01-01T00:00:00Z',
          Expires: '2017-01-01T00:00:00Z'
        },
        Locale: 'jp'
      }

      if @session_id
        operation.http_headers = {
          Cookie: 'CBSESSID=' + @session_id
        }
      end

      operation
    end

    def login
      operation = create_operation(:Util, :UtilLogin)

      operation.body = {
        parameters: {
          login_name: 'sato',
          password: ''
        }
      }

      result = operation.call
      resp = result.hash[:envelope][:body][:login_response]
      @session_id = resp[:returns][:cookie].strip.split[0].split('=')[1] if resp && resp[:returns]
    end
  end
end
