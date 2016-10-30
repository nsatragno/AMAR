module ES
  class Motor
    # Duración de un pulso en ciclos de la aplicación.
    DURACION = 10

    def initialize
      RPi::GPIO.setup GPIO_RELAY, :as => :output
      RPi::GPIO.set_low GPIO_RELAY

      # Indica la cantidad de pulsos restantes de motor.
      @ticks = 0
    end

    # Registra que se debe realizar un pulso.
    def pulso!
      @ticks = DURACION
    end

    def actualizar
      if @ticks > 0
        @ticks -= 1
        RPi::GPIO.set_high GPIO_RELAY
      else
        RPi::GPIO.set_low GPIO_RELAY
      end
    end
  end
end
