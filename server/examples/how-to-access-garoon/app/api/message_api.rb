class MessageAPI < Grape::API
  resource :'message-box' do
    resource :threads do
      desc 'Return the list of all threads'
      get do
        MessageService.list_threads
      end

      route_param :id, type: String, desc: 'A thread id.' do
        desc 'Return a thread'
        get do
          result = MessageService.get_thread_by_id(params[:id])
          result ? result : error!(:not_found, 404)
        end
      end
    end
  end
end
