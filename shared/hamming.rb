class Shared
  class Hamming
    def self.distance str1, str2
      # check to make sure that str1 is always the shorter string
      if str1.length > str2.length
        str1, str2 = str2, str1
      end

      tuples = binary_str1.split('').zip binary_str2.split('')

      distance = 0.0
      tuples.each do |a,b|
        if a != b
          distance += 1
        end
      end

      distance
    end
  end

end
