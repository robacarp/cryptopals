module Shared
  def xor_string string, byte
    string.split('').map {|c| (c.ord ^ byte).chr}.join
  end
end
