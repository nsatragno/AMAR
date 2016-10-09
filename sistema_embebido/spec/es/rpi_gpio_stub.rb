require "./lib/es/pines.rb"

# Evita cargar el módulo rpi_gpio en los tests.
module Kernel
  alias :old_require :require
  def require(path)
    old_require(path) unless path == "rpi_gpio"
  end
end

# Declaramos los módulos proporcionados por la biblioteca rpi_gpio, que estamos
# remplazando.
module RPi
  module GPIO
  end
end

module Mock
  # Mock de un puerto PWM.
  class PWM
    attr_reader :pin
    attr_reader :frecuencia

    attr_accessor :duty_cycle

    def initialize(pin, frecuencia)
      @pin = pin
      @frecuencia = frecuencia
      @running = false
    end

    def running?
      @running
    end

    def start(duty_cycle)
      @duty_cycle = duty_cycle
      @running = true
    end
     
    def stop
      @running = false
    end
  end
end
