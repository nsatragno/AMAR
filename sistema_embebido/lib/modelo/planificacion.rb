require './lib/modelo/momento'

# Maneja los horarios en los que se alimenta a la mascota.
class Planificacion
  ARCHIVO_PLANIFICACION = '/var/amar/planificacion'

  attr_reader :momentos

  def initialize(display)
    @display = display
    from_s! File.read ARCHIVO_PLANIFICACION
  end

  def actualizar
  end

  def to_s
    if @momentos.empty?
      return ""
    end
    @momentos.map do |momento|
      momento.to_s
    end.reduce do |s1, s2|
      s1 + ", " + s2
    end
  end

  def from_s!(s_momentos)
    @momentos = s_momentos.gsub(" ", "")
                          .split(",").map do |string|
      Momento.new string
    end
    @display.mensaje2 "Horarios: " + to_s
  end

  def guardar!
    File.write ARCHIVO_PLANIFICACION, to_s
  end
end
