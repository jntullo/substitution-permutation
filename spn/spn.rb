$:.unshift(File.dirname(__FILE__))
require 'permutation'
require 'substitution'
require 'xor'

module Spn
  class Spn
    def self.run(plaintext, pi_s, pi_p, key_schedule)
      w = []
      u = []
      v = []

      puts "w^0 = #{plaintext}"

      substitution = Substitution.new(pi_s)
      permutate = Permutation.new(pi_p)

      # Create the inputs
      (key_schedule.length - 2).times do |r|
        # u_results << xor_arrays(plaintext[r], key_schedule[r])
        u_r = Xor.xor_arrays(r.zero? ? plaintext : w[r - 1], key_schedule[r])
        puts "u^#{r+1} = #{u_r}"
        u << u_r
        v_r = substitution.run(u_r)
        puts "v^#{r+1} = #{v_r}"
        v << v_r
        w_r = permutate.run(v_r.join)
        puts "w^#{r+1} = #{w_r}"
        w << w_r
      end
      # Last iteration is different
      u_nr = Xor.xor_arrays(w.last, key_schedule[key_schedule.length-2])
      puts "u^4 = #{u_nr}"
      u << u_nr

      v_nr = substitution.run(u_nr)
      puts "v^f = #{v_nr}"
      v << v_nr

      y = Xor.xor_arrays(v_nr, key_schedule.last)
      puts "y = #{y}"

      { w: w, v: v, u: u }
    end
  end
end
