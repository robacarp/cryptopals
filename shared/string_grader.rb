module Shared
  class StringGrader
    LETTERS =  %w|a A b B c C d D e E f F g G h H i I j J k K l L m M n N o O p P q Q r R s S t T u U v V w W x X y Y z Z |

    # Thanks, Cornell
    LETTER_FREQUENCY = {
      A: 8.12, B: 1.49, C: 2.71, D: 4.32,
      E: 12.02, F: 2.30, G: 2.03, H: 5.92,
      I: 7.31, J: 0.10, K: 0.69, L: 3.98,
      M: 2.61, N: 6.95, O: 7.68, P: 1.82,
      Q: 0.11, R: 6.02, S: 6.28, T: 9.10,
      U: 2.88, V: 1.11, W: 2.09, X: 0.17,
      Y: 2.11, Z: 0.07
    }

    def self.grade *things, **stuff
      new(*things, **stuff).tap {|i| i.xor_decode }
    end

    attr_reader :grade, :decoded, :code

    def initialize string, b64_decode: false
      @byte_string = string

      if b64_decode
        @byte_string = [string].pack('H*')
      end
    end

    def xor_decode
      scores = {}

      (0x00..0xff).each do |byte|
        scores[byte] = grade_string xor_string @byte_string, byte
      end

      high_score = scores.to_a.sort {|a,b| a[1] <=> b[1]}.first
      @code  = high_score.first
      @grade = high_score.last
      @decoded = xor_string @byte_string, high_score.first
    end

    private

    def grade_string string
      letter_count = Hash.new(0)

      # Count up all the letters, exclude those that arent
      string.split('').each do |letter|
        next unless LETTERS.include? letter
        letter_count[letter.upcase.to_sym] += 1
      end

      # Calculate how much the found frequency deviates from the expected
      magnitudes = LETTER_FREQUENCY.map do |letter, frequency|
        (letter_count[letter] - frequency).abs
      end

      # Average all the magnitudes
      magnitudes.inject(0.0) { |sum, e| sum + e } / magnitudes.count
    end

    def xor_string string, byte
      string.split('').map {|c| (c.ord ^ byte).chr}.join
    end
  end
end

