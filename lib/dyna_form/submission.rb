module DynaForm
  class Submission

    def initialize(model, variables, attributes)
      @model = parse_model(model)
      @variables = variables.map(&:to_sym)
      @attributes = attributes.clone
    end    

    def submit!
      submit_helper(true)
    end

    def submit
      submit_helper(false)
    end

    private

    def submit_helper(dangerous)
      surplus = @variables - @attributes.keys
      if surplus.length > 0
        raise "Attempted to delegate a non-existed attribute variable"
      end

      attrs = @attributes.select { |k, _| @variables.include?(k.to_sym) }

      class_name = @model
      dangerous ? Kernel.const_get(class_name).create!(attrs) : Kernel.const_get(class_name).create(attrs)  
    end

    def parse_model(model)
      str_model = model.to_s
      words = str_model.split("_")
      words.map { |w| w[0..0].capitalize + w[1..-1] }.join("")
    end
  end
end
