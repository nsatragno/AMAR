require "./lib/es/hd44780"

module ES
  # Maneja el display LED del alimentador.
  class Display
    TAM_MAX = 16

    def initialize
      @handler = HD44780.new 17, 27, [22, 10, 9, 11]
    end

    def mensaje(string)
      @string = string
      @offset = 0
    end

    def update
      if string.length < TAM_MAX
        send = @message.rjust TAM_MAX, ' '
      else
        send = string.slice TAM_MAX, TAM_MAX + @offset
        @offset += 1
      end
      @handler.message send
    end
  end
end
