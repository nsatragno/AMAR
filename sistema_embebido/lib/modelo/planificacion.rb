# Maneja los horarios en los que se alimenta a la mascota.
class Planificacion
  def self.planificaciones
    @@planificaciones ||= []
  end

  def self.planificaciones_to_s
    if planificaciones.empty?
      return ""
    end
    Planificacion.planificaciones.map do |planificacion|
      planificacion.to_s
    end.reduce do |s1, s2|
      s1 + ", " + s2
    end
  end

  def self.generar_planificaciones(string_planificaciones)
    @@planificaciones = string_planificaciones.gsub(" ", "")
                                              .split(",").map do |string|
      Planificacion.new string
    end
  end

  attr_reader :hora
  attr_reader :minuto

  def initialize(string)
    @hora = (string.slice 0, 2).to_i
    @minuto = (string.slice 3, 5).to_i
  end

  def to_s
    "%02d_%02d" % [@hora, @minuto]
  end
end
