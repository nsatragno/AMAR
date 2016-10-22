require "./lib/modelo/estado.rb"

describe Estado do

  it "se convierte a JSON" do
    Estado.instance.recipiente_lleno = true
    Estado.instance.plato_lleno = true
    Estado.instance.detecta_movimiento = true
    expect(Estado.instance.to_json).to eq(
      "{\n" +
        "recipiente_lleno: true,\n" +
        "plato_lleno: true,\n" +
        "detecta_movimiento: true\n" +
      "}")
  end
end
