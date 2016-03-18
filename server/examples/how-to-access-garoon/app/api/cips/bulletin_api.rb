# This API example illustrates how to read data from a local cache database.
module CIPS
  class BulletinAPI < Grape::API
    resource :'bulletin-board' do
      resource :topics do
        desc 'Return the list of all topics'
        get do
          result = []

          BulletinTopic.all.each do |topic|
            result << topic.subset
          end

          result
        end

        route_param :topic_id, type: String, desc: 'A topic id.' do
          desc 'Return a topic'
          get do
            result = BulletinTopic.where(:@id => params[:topic_id]).first
            result ? result : error!(:not_found, 404)
          end
        end
      end

      resource :categories do
        desc 'Return a category tree.'
        get do
          BulletinCategory.first
        end

        route_param :category_id, type: String, desc: 'A category id.' do
          resource :topics do
            desc 'Return the list of topics in a category'
            get do
              result = []
              error!(:not_found, 404) if !BulletinCategory.where(:'root.categories.category.@id' => params[:category_id]).first

              BulletinTopic.where(:@category_id => params[:category_id]).each do |topic|
                result << topic.subset
              end

              result
            end
          end
        end
      end
    end
  end
end
