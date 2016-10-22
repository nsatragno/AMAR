require "./lib/modelo/planificacion.rb"

describe Planificacion do

  it "no se rompe si no tiene planificaciones" do
    expect(Planificacion.planificaciones_to_s).to eq("")
  end

  it "debe inicializar planificaciones a partir de un string" do
    string = "12_14, 23_31, 05_00"

    Planificacion.generar_planificaciones string

    planificaciones = Planificacion.planificaciones

    expect(planificaciones[0].hora).to eq(12)
    expect(planificaciones[0].minuto).to eq(14)
    expect(planificaciones[1].hora).to eq(23)
    expect(planificaciones[1].minuto).to eq(31)
    expect(planificaciones[2].hora).to eq(5)
    expect(planificaciones[2].minuto).to eq(0)
  end

  it "poder inicializarse a partir de un string válido" do
    plan = Planificacion.new "12_15"
    expect(plan.hora).to eq(12)
    expect(plan.minuto).to eq(15)
  end

  it "puede devolver las planificaciones cargadas como string" do
    string = "12_14, 23_31, 05_00"
    Planificacion.generar_planificaciones string
    expect(Planificacion.planificaciones_to_s).to eq(string)
  end

  it "puede devolver las planificaciones cargadas si no las hay" do
    Planificacion.generar_planificaciones ""
    expect(Planificacion.planificaciones_to_s).to eq("")
  end
end
