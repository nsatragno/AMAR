require "./lib/api/servidor.rb"
require "./lib/es/actuadores/display"
require "./lib/es/actuadores/led_indicador"
require "./lib/es/sensores/barrera"
require "./lib/es/sensores/movimiento"
require "./lib/modelo/estado"
require "./lib/modelo/planificacion"

# Envuelve toda la aplicación.
class Amar

  # El tiempo, en segundos, que se espera entre ciclos del bucle de aplicación.
  TIEMPO_SLEEP = 0.05

  # El tiempo máximo en segundos que se espera hasta que se cierre sinatra.
  API_TIMEOUT = 3

  def initialize
    # La numeración BCM es la misma que está en el break-out de la RPi.
    RPi::GPIO.set_numbering :bcm

    @led_indicador = ES::LedIndicador.new
    @barrera = ES::Barrera.new
    @sensor_movimiento = ES::SensorMovimiento.new
    @display = ES::Display.new
    Planificacion.display = @display
    Estado.instance.display = @display
    Planificacion.cargar!
  end

  # Ejecuta la aplicación.
  def ejecutar!
    @led_indicador.prender!

    # Se ejecuta la API en background.
    @thread_api = Thread.new do
      API::Servidor.run!
    end

    @display.mensaje1 "Hola humano"

    while @thread_api.alive? do
      @led_indicador.actualizar
      @barrera.actualizar
      @sensor_movimiento.actualizar
      Estado.instance.actualizar
      @display.actualizar
      sleep TIEMPO_SLEEP
    end

    @led_indicador.apagar!
    RPi::GPIO.clean_up
  end
end
