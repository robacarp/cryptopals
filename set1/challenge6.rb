=begin
Break repeating-key XOR
It is officially on, now.
This challenge isn't conceptually hard, but it involves actual error-prone coding. The other challenges in this set are there to bring you up to speed. This one is there to qualify you. If you can do this one, you're probably just fine up to Set 6.

There's a file here. It's been base64'd after being encrypted with repeating-key XOR.

Decrypt it.

Here's how:

Let KEYSIZE be the guessed length of the key; try values from 2 to (say) 40.
Write a function to compute the edit distance/Hamming distance between two strings. The Hamming distance is just the number of differing bits. The distance between:
  this is a test
and
  wokka wokka!!!

is 37. Make sure your code agrees before you proceed.

- For each KEYSIZE, take the first KEYSIZE worth of bytes, and the second KEYSIZE worth of bytes, and find the edit distance between them. Normalize this result by dividing by KEYSIZE.
- The KEYSIZE with the smallest normalized edit distance is probably the key. You could proceed perhaps with the smallest 2-3 KEYSIZE values. Or take 4 KEYSIZE blocks instead of 2 and average the distances.
- Now that you probably know the KEYSIZE: break the ciphertext into blocks of KEYSIZE length.
- Now transpose the blocks: make a block that is the first byte of every block, and a block that is the second byte of every block, and so on.
- Solve each block as if it was single-character XOR. You already have code to do this.
- For each block, the single-byte XOR key that produces the best looking histogram is the repeating-key XOR key byte for that block. Put them together and you have the key.
- This code is going to turn out to be surprisingly useful later on. Breaking repeating-key XOR ("Vigenere") statistically is obviously an academic exercise, a "Crypto 101" thing. But more people "know how" to break it than can actually break it, and a similar technique breaks something much more important.

No, that's not a mistake.
We get more tech support questions for this challenge than any of the other ones. We promise, there aren't any blatant errors in this text. In particular: the "wokka wokka!!!" edit distance really is 37.
=end

require 'byebug'
require 'base64'

def hamming_distance str1, str2
  # check to make sure that str1 is always the shorter string
  if str1.length > str2.length
    str1, str2 = str2, str1
  end

  # convert a string to a stream of unseperated bits
  convert_to_binary_string = -> (str) {
    str.split('')
       .map(&:ord)
       .map{|n| n.to_s(2)}
       .map{|word| '0' * (7 - word.length) + word}
       .join
  }

  binary_str1 = convert_to_binary_string[str1]
  binary_str2 = convert_to_binary_string[str2]

  tuples = binary_str1.split('').zip binary_str2.split('')

  distance = 0
  tuples.each do |a,b|
    if a != b
      distance += 1
    end
  end

  distance
end

data = Base64.decode64 File.readlines('challenge6.dat').join

key_results = (2..40).map do |keysize|
  [keysize, hamming_distance(data[0..keysize], data[keysize..(keysize*2)]) / keysize]
end

key_length = key_results.sort_by(&:last).first.first

debugger
puts 'hi'
