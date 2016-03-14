module Garoon
  class Client
    @@client = nil

    def initialize
      @@client = Savon.new('http://10.211.55.38/cgi-bin/cbgrn/grn.cgi?WSDL') if !@@client
      util_login
    end

    def create_header(action)
      {
        Action: action,
        Timestamp: {
          Created: '2017-01-01T00:00:00Z',
          Expires: '2017-01-01T00:00:00Z'
        },
        Locale: 'jp'
      }
    end

    def create_operation(type, action)
      operation = @@client.operation(type.to_s + 'Service', type.to_s + 'Port', action)
      operation.custom_header = create_header(action)

      if @session_id
        operation.http_headers = {
          Cookie: 'CBSESSID=' + @session_id
        }
      end

      operation
    end

    def util_login
      operation = create_operation(:Util, :UtilLogin)

      operation.body = {
        parameters: {
          #login_name: 'Administrator',
          #password: 'P@ssw0rd'
          #login_name: 'sato',
          login_name: 'nomura',
          password: ''
        }
      }

      result = operation.call
      resp = result.hash[:envelope][:body][:login_response]

      if resp && resp[:returns]
        @session_id = resp[:returns][:cookie].strip.split[0].split('=')[1]
      else
        nil
      end
    end

    def bulletin_get_topic_versions
      queried_table = QueriedTable.where(table_name: :bulletin_topic_versions).first_or_create
      start_time = queried_table.last_queried_time
      start_time ||= Time.gm(1970, 1, 2, 0, 0, 0)
      end_time = Time.now
      operation = create_operation(:Bulletin, :BulletinGetTopicVersions)

      operation.body = {
        parameters: {
          _start: start_time.iso8601,
          _end: end_time.iso8601
        }
      }

      # Todo: What if session cookie has been expired?
      resp = operation.call.hash[:envelope][:body][:bulletin_get_topic_versions_response]
      yield resp[:returns][:topic_item] if resp && resp[:returns]
      queried_table.last_queried_time = end_time + 1
      #queried_table.save
    end

    def bulletin_get_topic_by_ids(topics)
      operation = create_operation(:Bulletin, :BulletinGetTopicByIds)

      operation.body = {
        parameters: {
          topics: topics
        }
      }

      resp = operation.call.hash[:envelope][:body][:bulletin_get_topic_by_ids_response]
      yield resp[:returns][:topic] if resp && resp[:returns]
    end
 end
end
