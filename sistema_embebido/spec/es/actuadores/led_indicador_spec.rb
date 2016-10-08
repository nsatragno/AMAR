require "./spec/es/rpi_gpio_stub"

require "./lib/es/actuadores/led_indicador"

describe ES do

  describe ES::LedIndicador do

    LedIndicador = ES::LedIndicador

    CICLO_MIN = LedIndicador::CICLO_TRABAJO_MIN
    CICLO_MAX = LedIndicador::CICLO_TRABAJO_MAX
    FRECUENCIA = LedIndicador::FRECUENCIA

    before :all do
      RPi::GPIO::PWM = {}
    end

    before :each do
      expect(RPi::GPIO::PWM).to receive(:new) do |pin, frecuencia|
        @puerto = Mock::PWM.new pin, frecuencia
      end

      @led_indicador = LedIndicador.new

      expect(@puerto.duty_cycle).to eq(CICLO_MIN)
    end

    it "deja el LED apagado cuando todavía no arrancó" do
      @led_indicador.actualizar
      expect(@puerto.duty_cycle).to eq(CICLO_MIN)
    end

    it "va de cero a cien y vuelve cuando arrancó" do
      @led_indicador.prender!
      for i in CICLO_MIN..CICLO_MAX do
        expect(@puerto.duty_cycle).to eq(i)
        @led_indicador.actualizar
      end
      for i in (CICLO_MAX - 1)..CICLO_MIN do
        expect(@puerto.duty_cycle).to eq(i)
        @led_indicador.actualizar
      end
    end
  end
end
