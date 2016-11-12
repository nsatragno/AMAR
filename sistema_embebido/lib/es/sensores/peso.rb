module ES
  class SensorPeso
    def initialize
      RPi::GPIO.setup GPIO_PESO, :as => :input, :pull => :down
    end

    def actualizar
      Estado.instance.plato_lleno = RPi::GPIO.high? GPIO_PESO
    end
  end
end
