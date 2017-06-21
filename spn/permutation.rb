module Spn
  class Permutation
    attr_reader :pi_p

    def initialize(pi_p)
      @pi_p = pi_p
    end

    def run(binary_array)
      new_binary = binary_array.split('')
      swapped_binary = Array.new(16)
      new_binary.each_with_index do |val, index|
        new_index = pi_p[index.to_s]
        swapped_binary[new_index] = val
      end
      final_binary = []
      final_binary[0] = swapped_binary[0..3].join
      final_binary[1] = swapped_binary[4..7].join
      final_binary[2] = swapped_binary[8..11].join
      final_binary[3] = swapped_binary[12..15].join
      final_binary
    end
  end
end
