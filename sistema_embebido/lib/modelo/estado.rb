require "singleton"

# Modela el estado del dispenser de cereales.
class Estado
  include Singleton

  attr_accessor :recipiente_lleno
  attr_accessor :plato_lleno
  attr_accessor :detecta_movimiento

  def initialize
    @recipiente_lleno = false
    @plato_lleno = false
    @detecta_movimiento = false
  end

  def to_json
    "{\n" +
      "recipiente_lleno: #{@recipiente_lleno},\n" +
      "plato_lleno: #{@plato_lleno},\n" +
      "detecta_movimiento: #{@detecta_movimiento}\n" +
    "}"
  end
end
