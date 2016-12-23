=begin
Single-byte XOR cipher
The hex encoded string:

1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736
... has been XOR'd against a single character. Find the key, decrypt the message.

You can do this by hand. But don't: write code to do it for you.

How? Devise some method for "scoring" a piece of English plaintext. Character frequency is a good metric. Evaluate each output and choose the one with the best score.
=end

require 'byebug'
require_relative '../shared/xor_string'
require_relative '../shared/grade_string'

include Shared


scores = {}

code = "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"

bytes = 0x00..0xff

byte_string = [code].pack('H*')

bytes.each do |byte|
  scores[byte] = grade_string xor_string byte_string, byte
end

high_score = scores.to_a.sort {|a,b| a[1] <=> b[1]}.first

puts "String was xor'd across #{high_score[0].chr}"
puts "Message reads: #{xor_string byte_string, high_score[0]}"
