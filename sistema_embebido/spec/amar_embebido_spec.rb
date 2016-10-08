require "./spec/es/rpi_gpio_stub"

require "./lib/amar_embebido"

describe Amar do

  it "al construirse, configura la numeración tipo BCM" do
    expect(RPi::GPIO).to receive(:set_numbering).with(:bcm)

    allow(ES::LedIndicador).to receive(:new)
    Amar.new
  end
end
