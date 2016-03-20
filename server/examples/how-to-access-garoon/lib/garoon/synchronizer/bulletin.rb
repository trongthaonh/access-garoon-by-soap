module Garoon
  module Synchronizer
    class Bulletin
      class << self
        def run
          added_topics = []
          modified_topics = []
          bulletin = Garoon::Client.instance.bulletin

          topic_item_proc = Proc.new do |topic_item, is_draft|
            topic = {
              _topic_id: topic_item[:@id],
              _is_draft: is_draft
            }

            case topic_item[:@operation]
            when 'add' then
              added_topics << topic
            when 'modify' then
              modified_topics << topic
            when 'remove' then
              BulletinTopic.where(:@id => topic_item[:@id]).destroy
            end
          end

          bulletin.get_topic_versions do |topic_items|
            if topic_items
              topic_items.each do |topic_item|
                BulletinTopicVersion.new(topic_item).save
                topic_item_proc.call(topic_item, false)
              end
            end
          end

          bulletin.get_draft_topic_versions do |topic_items|
            if topic_items
              topic_items.each do |topic_item|
                BulletinDraftTopicVersion.new(topic_item).save
                topic_item_proc.call(topic_item, true)
              end
            end
          end

          # Todo: Store to our database, files and follows associated with topics.
          bulletin.get_topic_by_ids(added_topics) do |topics|
            if topics
              topics.each do |topic|
                BulletinTopic.new(topic).save
              end
            end
          end

          bulletin.get_topic_by_ids(modified_topics) do |topics|
            if topics
              topics.each do |topic|
                existing_topic = BulletinTopic.where(:@id => topic[:@id]).first

                if existing_topic
                  existing_topic.attributes = topic
                  existing_topic.save
                end
              end
            end
          end

          bulletin.get_categories do |categories|
            if categories
              existing_categories = BulletinCategory.first_or_create
              existing_categories.attributes = categories
              existing_categories.save
            end
          end
        end
      end
    end
  end
end
