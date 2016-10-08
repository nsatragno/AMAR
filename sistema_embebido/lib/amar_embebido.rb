# Envuelve toda la aplicación.
class Amar

  def initialize
    @led_indicador = ES::LedIndicador.new
  end

  # Ejecuta la aplicación.
  def run!
    @led_indicador.prender!

    while true do
      @led_indicador = ES::LedIndicador.new
    end
  end
end
