module Garoon
  class Client
    attr_reader :bulletin
    attr_reader :message

    def initialize(savon)
      @savon = savon
      @bulletin = Bulletin.new(self)
      @message = Message.new(self)
      # Todo: Instead of logging in here, receive a session cookie from the VPN server when a VPN connection is established.
      login
    end

    def call_operation(type, action, parameters = nil, prefix = nil)
      operation = @savon.operation(type.to_s + 'Service', type.to_s + 'Port', action)

      operation.custom_header = {
        Action: action,
        Timestamp: {
          Created: '2017-01-01T00:00:00Z',
          Expires: '2017-01-01T00:00:00Z'
        },
        Locale: 'jp'
      }

      operation.body = { parameters: parameters } if parameters

      if @session_id
        operation.http_headers = {
          Cookie: 'CBSESSID=' + @session_id
        }
      end

      # Todo: What if session cookie has been expired?
      resp = operation.call.hash[:envelope][:body][((prefix ? prefix.to_s : action.to_s.underscore) + '_response').to_sym]
      resp && resp[:returns] ? resp[:returns] : nil
    end

    def login
      parameter = {
        login_name: 'sato',
        password: ''
      }

      @session_id = nil
      ret = call_operation(:Util, :UtilLogin, parameter, :login)
      @session_id = ret[:cookie].strip.split[0].split('=')[1] if ret
    end
  end
end
