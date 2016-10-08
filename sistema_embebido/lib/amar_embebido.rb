require "./lib/es/actuadores/led_indicador"

# Envuelve toda la aplicación.
class Amar

  # El tiempo, en segundos, que se espera entre ciclos del bucle de aplicación.
  TIEMPO_SLEEP = 0.05

  def initialize
    # La numeración BCM es la misma que está en el break-out de la RPi.
    RPi::GPIO.set_numbering :bcm

    @led_indicador = ES::LedIndicador.new
  end

  # Ejecuta la aplicación.
  def ejecutar!
    @led_indicador.prender!

    loop do
      @led_indicador.actualizar

      sleep TIEMPO_SLEEP
    end
  end
end
