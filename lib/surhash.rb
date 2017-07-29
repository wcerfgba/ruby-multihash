##
# A surhash or surmap is a surjective, non-injective map, meaning that:
# * every key is associated with a value;
# * every value is associated with a key; and,
# * a value may be associated with many keys.
#
# = Use cases
# 
# A surhash can be used for clustering. Given a set of equivalence relations 
# +rs :Set( :Method(:X, :X, :Bool) )+, choose some +r(:X, :X) :Bool+. For each 
# pair +(a :X, b :X)+ such that +r(a, b) == true+, associate +a => r+ and 
# +b => r+. Internally the surmap will store the set of equivalent values for 
# each relation.
class SurHash
  ##
  # Constructor sugar.
  def self.[](pairs = Array.new)
    new(pairs)
  end

  def self.empty
    self[]
  end

  ##
  # Accept an initial list of lists of the forms +[ [k1, k2, ...], v ]+ and
  # +[ k, v ]+ and build a surmap by associating all keys for a given value 
  # through a canonical key, and mapping the canonical key on to the value.
  def initialize(pairs = Array.new)
    @key_hash = Hash.new
    @value_hash = Hash.new

    pairs.each { |(keys, value)|

      # Coerce +keys+ into an array if necessary.
      keys = Array(keys)

      # No empty keys.
      if keys.empty?
        raise KeyError, "empty keyset for value: #{value.inspect}"
      end

      # There may be better ways to choose a canonical key, but this seems fine
      # for now.
      canonical_key = keys.first

      keys.each { |key|

        if @key_hash.key? key
          raise KeyError, "multiple assignments for key: #{key.inspect}"
        end

        # Each key first maps to a canonical key.
        @key_hash[key] = canonical_key

      }

      # Only the canonical key maps to the value.
      @value_hash[canonical_key] = value

    }
  end

  def empty?
    @key_hash.empty? && @value_hash.empty?
  end

  ##
  # Return the size of the surhash. This is equal to the number of entries / 
  # key-value pairs in the surhash, and equal to the number of keys in the 
  # surhash.
  def size
    @key_hash.size
  end

  def keys
    @key_hash.keys
  end

  def values
    @value_hash.values
  end

  ##
  # Flatten a surhash into a list of pairs of associations +[k, v]+.
  def entries
    @key_hash.entries.map { |(key, canonical_key)|
      [key, @value_hash[canonical_key]]
    }
  end
end