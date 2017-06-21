module Spn
  class Substitution

    attr_reader :pi_s

    def initialize(pi_s)
      @pi_s = pi_s
    end

    def run(array)
      new_array = []
      array.each do |b|
        new_array.push(pi_s[b])
      end
      new_array
    end
  end
end
