module Garoon
  class Synchronizer
    def synchronize_bulletin
      added_topics = []
      modified_topics = []
      removed_topics = []

      @client.bulletin_get_topic_versions do |topic_items|
        topic_items.each do |topic_item|
          #BulletinTopicVersion.new(topic_item).save

          topic = {
            _topic_id: topic_item[:@id],
            _is_draft: false
          }

          case topic_item[:@operation]
          when 'add' then
            added_topics << topic
          when 'modify' then
            modified_topics << topic
          when 'remove' then
            removed_topics << topic
          end
        end
      end

      # Todo: Store to our database, files and follows associated with topics.
      @client.bulletin_get_topic_by_ids(added_topics) do |topics|
        topics.each do |topic|
          BulletinTopic.new(topic).save
        end
      end

      @client.bulletin_get_topic_by_ids(modified_topics) do |topics|
        topics.each do |topic|
          existing_topic = BulletinTopic.where(:@id => topic[:@id]).first
          existing_topic.attributes = topic
          existing_topic.save
        end
      end

      @client.bulletin_get_topic_by_ids(removed_topics) do |topics|
        topics.each do |topic|
          BulletinTopic.where(:@id => topic[:@id]).destroy
        end
      end
    end

    def run
      @client = Client.new
      # Todo: Instead of logging in here, receive a session cookie from the VPN server when a VPN connection is established.
      synchronize_bulletin
    end
  end
end
