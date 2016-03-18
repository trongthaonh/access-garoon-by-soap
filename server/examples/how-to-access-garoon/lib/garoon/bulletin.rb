module Garoon
  class Bulletin
    def initialize(client)
      @client = client
    end

    def get_topic_versions(&proc)
      get_versions(:BulletinTopicVersions, :BulletinGetTopicVersions, &proc)
    end

    def get_draft_topic_versions(&proc)
      get_versions(:BulletinDraftTopicVersions, :BulletinGetDraftTopicVersions, &proc)
    end

    def get_topic_by_ids(topics)
      if block_given? && topics && !topics.empty?
        parameters = {
          topics: topics
        }

        ret = @client.call_operation(:Bulletin, :BulletinGetTopicByIds, parameters)
        yield ret && ret[:topic] ? ret[:topic].ensure_array : nil
      end
    end

    def get_categories
      if block_given?
        ret = @client.call_operation(:Bulletin, :BulletinGetCategories)
        yield ret && ret[:categories] ? ret[:categories] : nil
      end
    end

    private

    def get_versions(table_name, action, &proc)
      queried_table = QueriedTable.where(table_name: table_name.underscore).first_or_create

      parameters = {
        _start: queried_table.start_time.iso8601,
        _end: queried_table.end_time.iso8601
      }

      if block_given?
        ret = @client.call_operation(:Bulletin, action, parameters)
        yield ret && ret[:topic_item] ? ret[:topic_item].ensure_array : nil
      end

      queried_table.save
    end
  end
end
