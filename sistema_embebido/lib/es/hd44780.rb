module ES
  # Handles a 16x2 LCD display.
  class HD44780

    COMMAND_SLEEP_TIME = 0.001

    def initialize(pin_rs, pin_e, pins_db)
      throw "RS pin required" unless pin_rs
      throw "E pin required" unless pin_e
      throw "DB pin required" unless pins_db
      throw "DB pin should be an array" unless pins_db.respond_to? :length
      throw "DB pin should have four elements" unless pins_db.length == 4

      @pin_rs = pin_rs
      @pin_e = pin_e
      @pins_db = pins_db

      [ @pin_rs, @pin_e, *@pins_db ].each do |pin|
        RPi::GPIO.setup pin, :as => :output
      end
      clear
    end

    # Blank / reset LCD.
    def clear
      cmd 0x33 # $33 8-bit mode
      cmd 0x32 # $32 8-bit mode
      cmd 0x28 # $28 8-bit mode
      cmd 0x0C # $0C 8-bit mode
      cmd 0x06 # $06 8-bit mode
      cmd 0x01 # $01 8-bit mode
    end

    # Send command to LCD.
    def cmd(bits, char_mode = false)
      sleep COMMAND_SLEEP_TIME
      bitarray = bits.to_s(2).rjust 8, '0'

      if char_mode
        RPi::GPIO.set_high @pin_rs
      else
        RPi::GPIO.set_low @pin_rs
      end

      printAll = Proc.new do |offset|
        @pins_db.each do |pin|
          RPi::GPIO.set_low pin
        end

        (0..3).each do |i|
          if bitarray[i + offset] == "1"
            RPi::GPIO.set_high @pins_db[3 - i]
          end
        end

        RPi::GPIO.set_high @pin_e
        RPi::GPIO.set_low @pin_e
      end

      printAll.call 0
      printAll.call 4
    end

    # Send string to LCD. Newline wraps to second line.
    def message(text)
      text.chars.each do |char|
        if char == "\n"
          cmd 0xC0 # next line
        else
          cmd char.ord, true
        end
      end
    end
  end
end
