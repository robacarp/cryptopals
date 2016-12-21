=begin
Fixed XOR
Write a function that takes two equal-length buffers and produces their XOR combination.

If your function works properly, then when you feed it the string:

1c0111001f010100061a024b53535009181c
... after hex decoding, and when XOR'd against:

686974207468652062756c6c277320657965
... should produce:

746865206b696420646f6e277420706c6179
=end
require 'byebug'

inputs = [
  '1c0111001f010100061a024b53535009181c',
  '686974207468652062756c6c277320657965'
]

expected_output = '746865206b696420646f6e277420706c6179'

def xor a, b
  left = pack(a).split('').map(&:ord)
  right = pack(b).split('').map(&:ord)
  x = []

  left.each.with_index do |byte, index|
    x[index] = byte ^ right[index]
  end

  unpack(x.map(&:chr).join)
end

debugger

def unpack thing
  thing.unpack('H*').first
end

def pack thing
  Array(thing).pack('H*')
end

unless expected_output == xor(*inputs)
  puts 'nope.'
  exit 1
end

puts 'yep'
