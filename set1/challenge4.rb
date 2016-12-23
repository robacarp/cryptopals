=begin
Detect single-character XOR
One of the 60-character strings in this file has been encrypted by single-character XOR.

Find it.

(Your code from #3 should help.)
=end

require 'byebug'
require_relative '../shared'
include Shared

strings = File.readlines 'challenge4.dat'
scores = strings.map do |string|
  StringGrader.grade string, b64_decode: true
end

winner = scores.sort {|a,b| a.grade <=> b.grade}.first

puts "Found strongest decode with #{winner.code}"
puts "Message reads: #{winner.decoded.inspect}"
