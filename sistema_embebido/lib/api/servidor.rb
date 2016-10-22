require "sinatra"
require "./modelo/estado"

module API

  # Proporciona una API sencilla para la conexión con el cliente de Android.
  class Servidor < Sinatra::Base
    set :bind, '0.0.0.0'
    set :port, '3000'

    get '/estado' do
      Estado.instance.to_json
    end
  end

end
