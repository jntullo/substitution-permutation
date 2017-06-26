require 'xor'
require 'terminal-table'
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
      @sorted_v = Array.new(v.size)
      find_u_indexes
      sort_u
      sort_v
      @u1_u4_v2 = u1_u4_v2
      @u3_u4_v1_v4 = u3_u4_v1_v4
      binding.pry
    end

    def run
      calculate_table_values
    end


    def calculate_table_values
      table = []
      16.times do |a|
        row = []
        a_binary = ("%04b" % a).split('')
        16.times do |b|
          b_binary = ("%04b" % b).split('')
          4.times do |i|

          end
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
      size = flat_u.size - 1
      size.times do |i|
        @sorted_u << "%04b" % i
      end
    end

    def sort_v
      indexes.each do |index, value|
        @sorted_v[index] = flat_v[value]
      end
      @sorted_v[11] = '0111'
    end

    def find_u_indexes
      flat_u.each_with_index do |binary_val, index|
        @indexes[binary_val.to_i(2)] = index
      end
      @indexes = indexes.sort_by { |k,v| k }.to_h
    end
  end
end
