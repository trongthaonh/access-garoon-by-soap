# This API example illustrates how to read data from a local cache database.
class BulletinService
  class << self
    def list_topics
      result = []

      BulletinTopic.all.each do |topic|
        result << subset_for_list(topic)
      end

      result
    end

    def get_topic_by_id(id)
      result = BulletinTopic.where(id).first

      if result
        result = result.attributes.to_h
        result.delete('_id')
      end

      result
    end

    def list_topics_by_category(id)
      return nil if !BulletinCategory.where(:'root.categories.category.@id' => id).first
      result = []

      BulletinTopic.where(:@category_id => id).each do |topic|
        result << subset_for_list(topic)
      end

      result
    end

    def get_categories
      result = BulletinCategory.first

      if result
        result = result.attributes.to_h
        result.delete('_id')
      end

      result
    end

    private

    def subset_for_list(topic)
      {
        :@id => topic[:@id],
        :@subject => topic[:@subject],
        creator: {
          :@name => topic[:creator][:@name],
          :@date => topic[:creator][:@date]
        }
      }
    end
  end
end
