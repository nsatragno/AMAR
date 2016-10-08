require "rpi_gpio"

require "./lib/es/pines.rb"

module ES
  # Un led que indica que el aplicativo está funcionando correctamente cambiando
  # su brillo.
  class LedIndicador

    FRECUENCIA = 100 # Hz.

    # Valores mínimos y máximos posibles para el ciclo de trabajo de la señal
    # PWM.
    CICLO_TRABAJO_MIN = 0
    CICLO_TRABAJO_MAX = 20

    # Número por el que se incrementa el ciclo de trabajo en cada iteración.
    PASO = 1

    # Inicializa el indicador.
    def initialize
      # Inicializo el puerto GPIO en salida PWM.
      RPi::GPIO.setup ES::GPIO_PWM, :as => :output
      RPi::GPIO.set_low ES::GPIO_PWM

      @puerto = RPi::GPIO::PWM.new(ES::GPIO_PWM, FRECUENCIA)

      # Número que se suma al ciclo de trabajo actual.
      @delta = PASO
    end

    # Inicia el ciclo del led.
    def prender!
      @puerto.start CICLO_TRABAJO_MIN
    end

    # Actualiza el led, cambiando su brillo.
    def actualizar
      return if not @puerto.running?
      if @puerto.duty_cycle >= CICLO_TRABAJO_MAX then
        @delta = -PASO
      elsif @puerto.duty_cycle <= CICLO_TRABAJO_MIN then
        @delta = PASO
      end
      @puerto.duty_cycle += @delta
    end
  end
end
