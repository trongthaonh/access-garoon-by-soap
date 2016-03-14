module CIPS
  class API < Grape::API
    prefix 'api'
    format :json

    resource :'garoon' do
      desc 'Synchronize our database with Garoon server.'
      get do
        # Todo: Run in the backgounrd using ActiveJob
        synchronizer = Garoon::Synchronizer.new
        synchronizer.run
      end
    end

    resource :'message-boxes' do
      resource :'inbox' do
        resource :'messages' do
          desc 'Return all messages.'
          get do
          end
        end
      end
    end
  end
end
