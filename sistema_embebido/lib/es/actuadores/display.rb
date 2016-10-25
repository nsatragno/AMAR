require "./lib/es/hd44780"

module ES
  # Maneja el display LED del alimentador.
  class Display
    TAM_MAX = 16

    def initialize
      @handler = HD44780.new 17, 27, [22, 10, 9, 11]
      @contador = 0
      @send_anterior = ""
    end

    def mensaje1(string)
      @mensaje1 = string
      @offset1 = 0
    end

    def mensaje2(string)
      @mensaje2 = string
      @offset2 = 0
    end

    def actualizar
      @contador += 1
      if @contador % 20 != 0
	return
      end

      send = ""
      # TODO arreglar manejo de offset, el proc no modifica las variables de instancia.
      procedimiento = Proc.new do |mensaje, offset|
        if mensaje.length <= TAM_MAX
          send += mensaje.center TAM_MAX, ' '
        else
          send += mensaje.slice offset, TAM_MAX
          offset += 1
        end
      end

      procedimiento.call @mensaje1, @offset1
      send += "\n"
      procedimiento.call @mensaje2, @offset2

      if send == @send_anterior
        return
      end
      @send_anterior = send

      @handler.clear
      @handler.message send
    end
  end
end
