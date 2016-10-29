require "sinatra"

module API

  # Proporciona una API sencilla para la conexión con el cliente de Android.
  class Servidor < Sinatra::Base
    set :bind, '0.0.0.0'
    set :port, '3000'

    before do
      content_type 'application/json'
    end

    get '/estado' do
      Estado.instance.to_json
    end

    post '/alimentar' do
      '"OK"'
    end

    get '/planificacion' do
      Planificacion.planificaciones_to_s
    end

    post '/planificacion' do
      Planificacion.generar_planificaciones params[:planificacion]
      Planificacion.guardar!
      "'OK'"
    end
  end

end
