require "./spec/es/rpi_gpio_stub"

require "./lib/amar_embebido"

describe Amar do

  before do
    # Debe establecer la numeración BCM.
    expect(RPi::GPIO).to receive(:set_numbering).with(:bcm)

    @led_indicador = instance_double("ES::LedIndicador")
    allow(ES::LedIndicador).to receive(:new) { @led_indicador }

    @app = Amar.new

    allow(@led_indicador).to receive(:prender!)
    allow(@led_indicador).to receive(:actualizar)
    allow(@led_indicador).to receive(:apagar!)
    allow(RPi::GPIO).to receive(:clean_up)
  end

  it "al ejecutar arranca el servidor" do
    thread = instance_double("Thread")
    expect(thread).to receive(:alive?).and_return(false)
    expect(API::Servidor).to receive(:run!).and_return thread
    allow(Thread).to receive(:new).and_yield

    @app.ejecutar!
  end

  it "al ejecutar enciende, actualiza y apaga el led indicador" do
    thread = instance_double("Thread")
    allow(thread).to receive(:alive?).and_return(true, false)
    allow(Thread).to receive(:new).and_return thread

    expect(@led_indicador).to receive(:prender!)
    expect(@led_indicador).to receive(:actualizar)
    expect(@led_indicador).to receive(:apagar!)
    expect(@app).to receive(:sleep).with(Amar::TIEMPO_SLEEP)
    expect(RPi::GPIO).to receive(:clean_up)

    @app.ejecutar!
  end
end
