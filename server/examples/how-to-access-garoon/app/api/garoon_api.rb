class GaroonAPI < Grape::API
  resource :garoon do
    desc 'Synchronize our database with Garoon server.'
    resource :sync do
      get do
        # Todo: Run in the backgounrd using ActiveJob
        Garoon::Synchronizer::All.run
      end
    end
  end
end
