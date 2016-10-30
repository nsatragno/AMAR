require './lib/modelo/momento'

require 'date'
require 'rufus-scheduler'

# Maneja los horarios en los que se alimenta a la mascota.
class Planificacion
  ARCHIVO_PLANIFICACION = '/var/amar/planificacion'

  attr_reader :momentos

  def initialize(display, motor)
    @display = display
    @motor = motor
    @scheduler = Rufus::Scheduler.new
    @jobs = []
    from_s! File.read ARCHIVO_PLANIFICACION
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

    @jobs.each { |job| job.unschedule }
    @jobs = []

    current_time = Time.now
    now_date = DateTime.parse current_time.to_s

    @momentos.each do |momento|
      then_date =
        DateTime.parse(current_time.strftime "%d-%m-%Y #{momento.to_s} %z")
      then_date = then_date.next_day if now_date > then_date

      @jobs << @scheduler.schedule_every('24h', :first_at => then_date.to_s) do
        @motor.pulsar!
      end
    end
  end

  def guardar!
    File.write ARCHIVO_PLANIFICACION, to_s
  end
end
