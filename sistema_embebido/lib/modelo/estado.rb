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
        if @plato_lleno
          @display.mensaje1 "Plato lleno"
        else
          @display.mensaje1 "Hola humano"
        end
      end
    else
      @display.mensaje1 "Llename"
    end
  end

  def to_s
    "#{@recipiente_lleno}_#{@plato_lleno}_#{@detecta_movimiento}"
  end
end
