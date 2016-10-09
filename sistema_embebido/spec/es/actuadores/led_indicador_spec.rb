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

      expect(RPi::GPIO).to receive(:setup).with(ES::GPIO_PWM, :as => :output)
      expect(RPi::GPIO).to receive(:set_low).with(ES::GPIO_PWM)

      @led_indicador = LedIndicador.new
    end

    it "deja el LED apagado cuando todavía no arrancó" do
      @led_indicador.actualizar
      expect(@puerto.duty_cycle).to be nil
      expect(@puerto.running?).to be false
    end

    it "permite apagar el led" do
      @led_indicador.prender!
      @led_indicador.actualizar
      @led_indicador.apagar!
      expect(@puerto.running?).to be false
    end

    it "va de cero a cien y vuelve cuando arrancó" do
      @led_indicador.prender!
      expect(@puerto.running?).to be true
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
