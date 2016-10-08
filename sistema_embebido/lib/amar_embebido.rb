require "./lib/es/actuadores/led_indicador"

# Envuelve toda la aplicación.
class Amar

  def initialize
    # La numeración BCM es la misma que está en el break-out de la RPi.
    RPi::GPIO.set_numbering :bcm

    @led_indicador = ES::LedIndicador.new
  end

  # Ejecuta la aplicación.
  def run!
    @led_indicador.prender!

    while true do
      @led_indicador.update
    end
  end
end
