class Momento
  attr_reader :hora
  attr_reader :minuto

  def initialize(string)
    @hora = (string.slice 0, 2).to_i
    @minuto = (string.slice 3, 5).to_i
  end

  def to_s
    "%02d:%02d" % [@hora, @minuto]
  end
end
