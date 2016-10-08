require "./spec/es/rpi_gpio_stub"

require "./lib/amar_embebido"

describe Amar do

  before do
    # Debe establecer la numeración BCM.
    expect(RPi::GPIO).to receive(:set_numbering).with(:bcm)

    @led_indicador = instance_double("ES::LedIndicador")
    allow(ES::LedIndicador).to receive(:new) { @led_indicador }

    @app = Amar.new
  end

  it "al ejecutar enciende y actualiza el led indicador" do
    expect(@led_indicador).to receive(:prender!)
    expect(@led_indicador).to receive(:actualizar)

    allow(@app).to receive(:loop).and_yield
    @app.ejecutar!
  end
end
