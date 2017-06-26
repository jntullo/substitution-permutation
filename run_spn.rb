$:.unshift(File.dirname(__FILE__))
require 'pry'
require 'spn/spn'
require 'spn/key_schedule'
require 'spn/table_vals'
require 'terminal-table'

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

k_3_1 = %w(0011 1010 1001 0100 1101 0110 0011 1111)
plaintext_3_1 = %w(0010 0110 1011 0111)

key_schedule_3_1 = Spn::KeySchedule.build(k_3_1, plaintext_3_1.size)
spn_results_3_1 = Spn::Spn.run(plaintext_3_1, pi_s_3_1, pi_p_3_1, key_schedule_3_1)

table_vals = Spn::TableVals.new(spn_results_3_1[:u], spn_results_3_1[:v])
table_vals.run
