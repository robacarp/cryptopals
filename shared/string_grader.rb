class Shared
  class StringGrader
    LETTERS =  %w|a A b B c C d D e E f F g G h H i I j J k K l L m M n N o O p P q Q r R s S t T u U v V w W x X y Y z Z |
    LETTERS << ' '

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

    def self.grade string
      new(string)
    end

    def inspect
      {
        grade: @grade,
        code: @code
      }.inspect
    end

    attr_reader :grade, :decoded, :code, :scores

    def initialize string
      @byte_string = string
      grade_string string
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

  end
end

