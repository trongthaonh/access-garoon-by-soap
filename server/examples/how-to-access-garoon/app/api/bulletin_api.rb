class BulletinAPI < Grape::API
  resource :'bulletin-board' do
    resource :topics do
      desc 'Return the list of all topics'
      get do
        BulletinService.list_topics
      end

      route_param :topic_id, type: String, desc: 'A topic id.' do
        desc 'Return a topic'
        get do
          result = BulletinService.get_topic_by_id(params[:topic_id])
          result ? result : error!(:not_found, 404)
        end
      end
    end

    resource :categories do
      desc 'Return a category tree.'
      get do
        result = BulletinService.get_categories
        result ? result : error!(:not_found, 404)
      end

      route_param :category_id, type: String, desc: 'A category id.' do
        resource :topics do
          desc 'Return the list of topics in a category'
          get do
            result = BulletinService.list_topics_by_category(params[:category_id])
            result ? result : error!(:not_found, 404)
          end
        end
      end
    end
  end
end
