module DynaForm

  # Some of the older versions of Rails do not contain Hashes with
  # indifferent access. To accomodate the older versions, this class
  # was made to make development possible. Yes, some might think
  # I am recreating a wheel, but as long as it gets the job done,
  # who cares.
  #
  # @author Willux <zaikaus1@gmail.com>
  class IndifferentAccessHash

    # Create a hash that has an indifferent access.
    #
    # @param [Hash<Object, Object>] hash The hash that we want to be able to give
    # indifferent access.
    def initialize(hash = {})
      @hash = {}
      hash.each do |k, v|
        @hash[stringify(k)] = v
      end
    end

    # Add a new key value pair into the hash.
    # To ensure that the hash indifferent access capabilities,
    # the key gets cast to a string (if possible). So now when a user
    # uses a stringifiable type or a string, they will be able to access
    # the same value.
    #
    # @param [Object] key
    # @param [Object] value
    def []=(key, value)
      @hash[stringify(key)] = value
    end

    # Retrieves the value based on the given key.
    # If the key is of stringifiable type, it will be casted into a
    # string and then the value will be retrieved. This way the user
    # can pass in a string or a stringifiable type if need be to get
    # the needed value.
    #
    # @param [Object] key
    #
    # @return [Object] the value the user is trying to retrieve.
    def [](key)
      @hash[stringify(key)]
    end

    private

    # Check if the type of the object can be cast to a string in our case.
    # For most other objects we don't care about casting to string, but for
    # the convenience of the user, these should be.
    #
    # @param [Object] object The method checks if this object can be cast to
    # string in this context.
    #
    # @return [Boolean] TRUE if the object can be cast to string in this
    # context. FALSE otherwise.
    def stringifiable?(object)
      [Float, Fixnum, Symbol, TrueClass, FalseClass].include?(object.class)
    end

    # Cast the given object into a string provided that the object is
    # stringifiable.
    #
    # @param [Object] object The object that this method is trying to cast to a
    # string.
    #
    # @return [Object] The string representation of the object if the object
    # is stringifiable in this context. Otherwise, return the original passed in
    # object.
    def stringify(object)
      stringifiable?(object) ? object.to_s : object
    end
  end
end
