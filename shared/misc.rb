class Shared
  class << self
    def xor_decode byte_string
      scores = {}

      (0x00..0xff).each do |byte|
        scores[byte] = StringGrader.grade xor_string(byte_string, byte)
      end

      high_score = scores.to_a.sort_by(&:first).last
      code  = high_score.first
      grade = high_score.last
      decoded = xor_string byte_string, high_score.first
    end

    def convert_to_binary_string str
      # convert a string to a stream of unseperated bits
      str.split('')
         .map(&:ord)
         .map{|n| n.to_s(2)}
         .map{|word| '0' * (7 - word.length) + word}
         .join
    end

    def xor_string string, byte
      string.split('').map {|c| (c.ord ^ byte).chr}.join
    end

    def b64_decode string
      [string].pack('H*')
    end
  end
end
