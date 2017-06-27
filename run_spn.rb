$:.unshift(File.dirname(__FILE__))
require 'pry'
require 'spn/spn'
require 'spn/key_schedule'
require 'spn/table_vals'


# This is proving example 3.1 in the textbook
pi_s_3_1 = {
  '0000' => '1110',
  '0001' => '0100',
  '0010' => '1101',
  '0011' => '0001',
  '0100' => '0010',
  '0101' => '1111',
  '0110' => '1011',
  '0111' => '1000',
  '1000' => '0011',
  '1010' => '0110',
  '1011' => '1100',
  '1100' => '0101',
  '1101' => '1001',
  '1110' => '0000',
  '1111' => '0111',
  '1001' => '1010'
}

pi_p_3_1 = {
  '0' => 0,
  '1' => 4,
  '2' => 8,
  '3' => 12,
  '4' => 1,
  '5' => 5,
  '6' => 9,
  '7' => 13,
  '8' => 2,
  '9' => 6,
  '10' => 10,
  '11' => 14,
  '12' => 3,
  '13' => 7,
  '14' => 11,
  '15' => 15
}


puts "The following are the output calculations for example 3.1 in the textbook"
k_3_1 = %w(0011 1010 1001 0100 1101 0110 0011 1111)
plaintext_3_1 = %w(0010 0110 1011 0111)

key_schedule_3_1 = Spn::KeySchedule.build(k_3_1, plaintext_3_1.size)
spn_results_3_1 = Spn::Spn.run(plaintext_3_1, pi_s_3_1, pi_p_3_1, key_schedule_3_1)

table_vals = Spn::TableVals.new(spn_results_3_1[:u], spn_results_3_1[:v])
table_vals.run

puts "The following are the output calculations for homework problem 3.14 a:"

def binary_calc(val)
  "%04b" % val
end

pi_s_3_14 = {
  '0000' => binary_calc(8),
  '0001' => binary_calc(4),
  '0010' => binary_calc(2),
  '0011' => binary_calc(1),
  '0100' => 'C'.to_i(16).to_s(2),
  '0101' => binary_calc(6),
  '0110' => binary_calc(3),
  '0111' => 'D'.to_i(16).to_s(2),
  '1000' => 'A'.to_i(16).to_s(2),
  '1010' => binary_calc(5),
  '1011' => 'E'.to_i(16).to_s(2),
  '1100' => binary_calc(7),
  '1101' => 'F'.to_i(16).to_s(2),
  '1110' => 'B'.to_i(16).to_s(2),
  '1111' => binary_calc(9),
  '1001' => binary_calc(0)
}

spn_results_3_4 = Spn::Spn.run(plaintext_3_1, pi_s_3_14, pi_p_3_1, key_schedule_3_1)

table_vals = Spn::TableVals.new(spn_results_3_4[:u], spn_results_3_4[:v])
table_vals.run
