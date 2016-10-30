module ES
  class Barrera
    attr_reader :nivel

    def initialize
      RPi::GPIO.setup GPIO_FOTOTRANSISTOR, :as => :input, :pull => :down
      RPi::GPIO.setup GPIO_EMISOR_IR, :as => :output
    end

    def actualizar
      RPi::GPIO.set_high GPIO_EMISOR_IR
      Estado.instance.recipiente_lleno = RPi::GPIO.low? GPIO_FOTOTRANSISTOR
    end
  end
end
