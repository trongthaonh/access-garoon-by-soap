# This API example illustrates how to directly fetch data from Garoon server without using local cache database.
# It takes a long time to return a result to client.
# We need to consider how to effectively cache Garoon data.
class MessageService
  class << self
    def list_threads
      client = Garoon::Client.instance
      thread_ids = []

      client.message.get_thread_versions do |thread_items|
        if thread_items
          thread_items.each do |thread_item|
            thread_ids << thread_item[:@id]
          end
        end
      end

      result = []

      client.message.get_threads_by_id(thread_ids) do |threads|
        if threads
          threads.each do |thread|
            result << subset_for_list(thread)
          end
        end
      end

      result
    end

    def get_thread_by_id(id)
      result = nil

      Garoon::Client.instance.message.get_threads_by_id([id]) do |threads|
        result = threads[0] if threads && threads.size > 0
      end

      result
    end

    private

    def subset_for_list(attr)
      {
        :@id => attr[:@id],
        :@subject => attr[:@subject],
        creator: {
          :@name => attr[:creator][:@name],
          :@date => attr[:creator][:@date]
        }
      }
    end
  end
end
