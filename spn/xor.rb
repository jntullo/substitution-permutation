module Spn
  class Xor
    def self.run(x, y)
      result = []
      x = x.split('')
      y = y.split('')
      x.size.times do |i|
        binary = x[i].to_i ^ y[i].to_i
        result.push(binary)
      end
      result.join
    end

    def self.three_vals(x, y, z)
      x.to_i ^ y.to_i ^ z.to_i
    end

    def self.four_vals(x, y, z, a)
      x.to_i ^ y.to_i ^ z.to_i ^ a.to_i
    end

    def self.xor_arrays(x, y)
      new_vals = []
      x.size.times do |i|
        new_vals.push(run(x[i], y[i]))
      end
      new_vals
    end
  end
end
