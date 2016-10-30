module ES
  class SensorMovimiento
    def initialize
      RPi::GPIO.setup GPIO_MOVIMIENTO, :as => :input
    end

    def actualizar
      Estado.instance.detecta_movimiento = RPi::GPIO.high? GPIO_MOVIMIENTO
    end
  end
end
