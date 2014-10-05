module DynaForm
  class Base
    extend ActiveModel::Naming
    extend DynaForm::Macros

    include ActiveModel::Conversion
    include ActiveModel::Validations

    def initialize(args = {})
      @lazy_initialization = (args == {})
      args.each do |key, val|
        create_var(key, val)
      end
    end

    def method_missing(method, *arguments, &block)
      @lazy_initialization ? create_var(method, arguments.first) : super
    end

    def submit
      result = true
      submissions.each { |s| result && s.submit }
      result
    end

    def persisted?
      false
    end

    protected

    def submissions
      return @submissions unless @submissions.nil?

      @submissions = []

      # TODO: we might be able to change this to just @@fields. More testing
      # will be required to ensure that that is the case.
      fields = self.class.class_variable_get(:@@fields)
      fields.each do |model, variables|
        @submissions << DynaForm::Submission.new(model, variables, attributes)
      end
      @submissions
    end

    def attributes
      return @attributes unless @attributes.nil?

      @attributes = {}
      instance_variables.each do |var|
        attribute = var.to_s[1..-1].to_sym
        @attributes[attribute] = instance_variable_get(var)
      end
      @attributes
    end

    def create_var(var_name, var_value)
      updated_var_name =  if var_name[-1, 1] == '='
                            var_name[0...-1]
                          else
                            var_name
                          end

      self.instance_variable_set("@#{updated_var_name}", var_value)

      self.class.instance_eval do
        attr_accessor "#{updated_var_name}"
      end
    end
  end
end
