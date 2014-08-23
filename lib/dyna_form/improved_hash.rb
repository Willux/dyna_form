module DynaForm
  class ImprovedHash
    def initialize(hash = {})
      @hash = stringify_keys(hash)
    end

    def []=(key, value)
      @hash[stringify(key)] = value
    end

    def [](key)
      @hash[stringify(key)]
    end

    private

    def stringify_keys(hash)
      new_hash = {}
      hash.each do |k, v|
        new_hash[stringify(key)] = v
      end
      new_hash
    end

    def stringifiable?(object)
      [Float, Fixnum, Symbol, TrueClass, FalseClass].include?(object.class)
    end

    def stringify(object)
      stringifiable?(object) ? object.to_s : object
    end
  end
end
