require "singleton"

# Modela el estado del dispenser de cereales.
class Estado
  include Singleton

  attr_accessor :detecta_movimiento
  attr_accessor :plato_lleno
  attr_accessor :recipiente_lleno

  attr_writer :display

  def initialize
    @recipiente_lleno = false
    @plato_lleno = false
    @detecta_movimiento = false
  end

  def actualizar
    if @recipiente_lleno
      if @detecta_movimiento
        @display.mensaje1 "Movimiento detectado"
      else
        @display.mensaje1 "Hola humano"
      end
    else
      @display.mensaje1 "Llename"
    end
  end

  def to_json
    "{\n" +
      "recipiente_lleno: #{@recipiente_lleno},\n" +
      "plato_lleno: #{@plato_lleno},\n" +
      "detecta_movimiento: #{@detecta_movimiento}\n" +
    "}"
  end
end
