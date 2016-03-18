module CIPS
  class API < Grape::API
    prefix 'api'
    format :json

    helpers do
      def savon
        @@savon ||= Savon.new(CIPS::Application.config.garoon_wsdl_url)
      end
    end

    resource :garoon do
      desc 'Synchronize our database with Garoon server.'
      resource :sync do
        get do
          # Todo: Run in the backgounrd using ActiveJob
          Garoon::Synchronizer::All.new(Garoon::Client.new(savon)).run
        end
      end
    end

    mount CIPS::BulletinAPI
    mount CIPS::MessageAPI
  end
end
