module CIPS
  class API < Grape::API
    prefix 'api'
    format :json

    helpers do
      def savon
        @@savon ||= Savon.new('http://10.211.55.38/cgi-bin/cbgrn/grn.cgi?WSDL')
      end
    end

    resource :'garoon' do
      desc 'Synchronize our database with Garoon server.'
      get do
        # Todo: Run in the backgounrd using ActiveJob
        synchronizer = Garoon::Synchronizer.new(savon)
        synchronizer.run
      end
    end

    resource :'bbs' do
      resource :'messages' do
        desc 'Return all messages.'
        get do
          topics = []

          BulletinTopic.all.each do |topic|
            topics << { id: topic[:@id], subject: topic[:@subject], creator: topic[:creator][:@name], created_at: topic[:creator][:@date] }
          end

          topics
        end
      end
    end
  end
end
