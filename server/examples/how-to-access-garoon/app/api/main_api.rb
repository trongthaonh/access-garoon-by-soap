class MainAPI < Grape::API
  prefix 'api'
  format :json

  mount GaroonAPI
  mount BulletinAPI
  mount MessageAPI
end
