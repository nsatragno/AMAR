require "./lib/api/servidor.rb"
require "./lib/es/actuadores/display"
require "./lib/es/actuadores/led_indicador"
require "./lib/es/actuadores/motor"
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
    @motor = ES::Motor.new
    @barrera = ES::Barrera.new
    @sensor_movimiento = ES::SensorMovimiento.new
    @display = ES::Display.new
    @planificacion = Planificacion.new @display, @motor
    Estado.instance.display = @display
  end

  # Ejecuta la aplicación.
  def ejecutar!
    @led_indicador.prender!

    # Se ejecuta la API en background.
    @thread_api = Thread.new do
      API::Servidor.planificacion = @planificacion
      API::Servidor.motor = @motor
      API::Servidor.run!
    end

    while @thread_api.alive? do
      # Primero se actualizan los sensores.
      @barrera.actualizar
      @sensor_movimiento.actualizar

      # Luego los actuadores.
      @motor.actualizar
      @led_indicador.actualizar

      # Finalmente, el estado y el display.
      Estado.instance.actualizar
      @display.actualizar

      sleep TIEMPO_SLEEP
    end

    @led_indicador.apagar!
    RPi::GPIO.clean_up
  end
end
