=begin
Single-byte XOR cipher
The hex encoded string:

1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736
... has been XOR'd against a single character. Find the key, decrypt the message.

You can do this by hand. But don't: write code to do it for you.

How? Devise some method for "scoring" a piece of English plaintext. Character frequency is a good metric. Evaluate each output and choose the one with the best score.
=end

require 'byebug'


scores = {}

code = "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"

bytes = 0x00..0xff

def summarize string
  letters =  %w|a b c d e f g h i j k l m n o p q r s t u v w x y z|
  letters += %w|A B C D E F G H I J K L M N O P Q R S T U V W X Y Z|

  # Thanks, Cornell
  letter_frequency = {
    A: 8.12, B: 1.49, C: 2.71, D: 4.32,
    E: 12.02, F: 2.30, G: 2.03, H: 5.92,
    I: 7.31, J: 0.10, K: 0.69, L: 3.98,
    M: 2.61, N: 6.95, O: 7.68, P: 1.82,
    Q: 0.11, R: 6.02, S: 6.28, T: 9.10,
    U: 2.88, V: 1.11, W: 2.09, X: 0.17,
    Y: 2.11, Z: 0.07
  }

  letter_count = Hash.new(0)
  string.split('').each do |letter|
    next unless letters.include? letter
    letter_count[letter.upcase.to_sym] += 1
  end

  magnitudes = letter_frequency.map do |letter, frequency|
    (letter_count[letter] - frequency).abs
  end

  magnitudes.inject(0.0) { |sum, e| sum + e } / magnitudes.count
end

def xor_string string, byte
  string.split('').map {|c| (c.ord ^ byte).chr}.join
end

byte_string = [code].pack('H*')

bytes.each do |byte|
  scores[byte] = summarize xor_string byte_string, byte
end

high_score = scores.to_a.sort {|a,b| a[1] <=> b[1]}.first

puts "String was xor'd across #{high_score[0].chr}"
puts "Message reads: #{xor_string byte_string, high_score[0]}"
