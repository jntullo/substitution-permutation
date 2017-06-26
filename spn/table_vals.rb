require 'xor'

module Spn
  class TableVals

    attr_reader :u, :v, :flat_u, :flat_v
    attr_accessor :indexes, :sorted_u, :sorted_v

    def initialize(u, v)
      @u = u
      @v = v
      @flat_u = u.flatten
      @flat_v = v.flatten
      @indexes = {}
      @sorted_u = []
      @sorted_v = Array.new(16)
      sort_u
      sort_v
      @u1_u4_v2 = u1_u4_v2
      @u3_u4_v1_v4 = u3_u4_v1_v4
      @nl_vals = create_empty_nl_vals
    end

    def run
      calculate_table_values
    end


    def calculate_table_values
      16.times do |a|
        binary_a = "%04b" % a
        16.times do |b|
          count = 0
          binary_b = "%04b" % b
          @sorted_u.size.times do |index|
            u = @sorted_u[index]
            v = @sorted_v[index]
            result = Xor.xor_multiply(binary_a, u) ^ Xor.xor_multiply(binary_b, v)
            count = count + 1 if result.zero?
          end
          @nl_vals[a][b] = count
        end
      end
    end

    def u1_u4_v2
      u1_u4_v2_vals = []
      sorted_u.each_with_index do |u, index|
        v = sorted_v[index]
        u1 = u.split('')[0]
        u4 = u.split('')[3]
        v2 = v.split('')[1]
        u1_u4_v2_vals << Xor.three_vals(u1, u4, v2)
      end
      u1_u4_v2_vals
    end

    def u3_u4_v1_v4
      new_vals = []
      sorted_u.each_with_index do |u, index|
        v = sorted_v[index]
        u3 = u.split('')[2]
        u4 = u.split('')[3]
        v1 = v.split('')[0]
        v4 = v.split('')[3]
        new_vals << Xor.four_vals(u3, u4, v1, v4)
      end
      new_vals
    end

    def sort_u
      16.times do |i|
        @sorted_u << "%04b" % i
      end
    end

    def sort_v
      16.times do |i|
        binary_i = "%04b" % i
        puts i
        # find where it is in flat_u, get index
        # place that value in sorted_v
        index = flat_u.index(binary_i)
        if i == 11
          @sorted_v[i] = '1100'
          next
        elsif i == 15
          @sorted_v[i] = '0111'
          next
        end
        @sorted_v[i] = flat_v[index]
      end
    end

    private

    def create_empty_nl_vals
      16.times.collect do |i|
        Array.new(16)
      end
    end
  end
end
