module Spn
  class KeySchedule
    def self.build(key, plaintext_length)
      ks = []
      i = 0
      j = plaintext_length - 1
      while j < key.length
        ks.push(key[i..j])
        i = i + 1
        j = j + 1
      end
      ks
    end
  end
end
