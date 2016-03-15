module Garoon
  class Bulletin
    def initialize(client)
      @client = client
    end

    def get_topic_versions
      queried_table = QueriedTable.where(table_name: :bulletin_topic_versions).first_or_create
      start_time = queried_table.last_queried_time
      start_time ||= Time.gm(1970, 1, 2, 0, 0, 0)
      end_time = Time.now
      operation = @client.create_operation(:Bulletin, :BulletinGetTopicVersions)

      operation.body = {
        parameters: {
          _start: start_time.iso8601,
          _end: end_time.iso8601
        }
      }

      # Todo: What if session cookie has been expired?
      resp = operation.call.hash[:envelope][:body][:bulletin_get_topic_versions_response]
      yield resp[:returns][:topic_item].ensure_array if resp && resp[:returns]
      queried_table.last_queried_time = end_time + 1
      queried_table.save
    end

    def get_topic_by_ids(topics)
      operation = @client.create_operation(:Bulletin, :BulletinGetTopicByIds)

      operation.body = {
        parameters: {
          topics: topics
        }
      }

      resp = operation.call.hash[:envelope][:body][:bulletin_get_topic_by_ids_response]
      yield resp[:returns][:topic].ensure_array if resp && resp[:returns]
    end
  end
end
