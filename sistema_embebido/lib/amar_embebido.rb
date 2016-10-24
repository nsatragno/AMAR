require "./lib/api/servidor.rb"
require "./lib/es/actuadores/display"
require "./lib/es/actuadores/led_indicador"
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
    @display = Display.new
  end

  # Ejecuta la aplicación.
  def ejecutar!
    @led_indicador.prender!

    # Se ejecuta la API en background.
    @thread_api = Thread.new do
      API::Servidor.run!
    end

    @display.mensaje "Este es ab23fffe2 pruebbaa331322 jajaja te agarre"

    while @thread_api.alive? do
      @led_indicador.actualizar
      @display.actualizar
      sleep TIEMPO_SLEEP
    end

    @led_indicador.apagar!
    RPi::GPIO.clean_up
  end
end
