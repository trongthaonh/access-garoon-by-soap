# This API example illustrates how to directly fetch data from Garoon server without using local cache database.
# It takes a long time to return result to client.
# We need to consider how to effectively cache Garoon data.
module CIPS
  class MessageAPI < Grape::API
    helpers do
      def subset_thread(thread)
        {
          id: thread[:@id],
          subject: thread[:@subject],
          creator: {
            name: thread[:creator][:@name],
            date: thread[:creator][:@date]
          }
        }
      end
    end

    resource :'message-box' do
      resource :threads do
        desc 'Return the list of all threads'
        get do
          thread_ids = []
          client = Garoon::Client.new(savon)
          message = client.message

          message.get_thread_versions do |thread_items|
            if thread_items
              thread_items.each do |thread_item|
                thread_ids << thread_item[:@id]
              end
            end
          end

          result = []

          message.get_threads_by_id(thread_ids) do |threads|
            if threads
              threads.each do |thread|
                result << subset_thread(thread)
              end
            end
          end

          result
        end

        route_param :id, type: String, desc: 'A thread id.' do
          desc 'Return a thread'
          get do
            client = Garoon::Client.new(savon)
            message = client.message

            message.get_threads_by_id([params[:id]]) do |threads|
              threads && threads.size > 0 ? threads[0] : error!(:not_found, 404)
            end
          end
        end
      end
    end
  end
end
