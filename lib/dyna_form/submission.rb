module DynaForm
  class Submission

    def initialize(model, variables, attributes)
      @model = parse_model(model)
      @variables = variables.map(&:to_sym)
      @attributes = attributes.clone
    end    

    def submit
      attrs = @attributes.select { |k, _| @variables.include?(k.to_sym) }

      class_name = @model
      new_object = Kernel.const_get(class_name).new(attrs)
      new_object.save
    end

    private

    def parse_model(model)
      str_model = model.to_s
      words = str_model.split("_")
      words.map { |w| w[0..0].capitalize + w[1..-1] }.join("")
    end
  end
end
