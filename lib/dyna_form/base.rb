module DynaForm
  class Base
    extend ActiveModel::Naming
    extend DynaForm::Constants

    include ActiveModel::Conversion
    include ActiveModel::Validations

    class << self
      def submit(*args, hash)
        updated_hsh = hash.with_indifferent_access
        unless updated_hsh.length == SUBMIT_HASH_LIMIT && updated_hsh.has_key?(:to)
          raise "Invalid parameter list." 
        end

        raw_model = updated_hsh[:to].to_s
        words = raw_model.split("_")
        model_name = words.map { |w| w[0..0].capitalize + w[1..-1] }.join("")
        
        fields =  begin
                    class_variable_get(:@@fields)
                  rescue NameError
                    class_variable_set(:@@fields, {})
                    {}
                  end

        fields[model_name] ||= []
        fields[model_name] += args
        class_variable_set(:@@fields, fields)
      end
    end

    def initialize(args = {})
      @lazy_initialization = (args == {})
      args.each do |key, val|
        create_var(key, val)
      end
    end

    def method_missing(method, *arguments, &block)
      @lazy_initialization ? create_var(method, arguments.first) : super
    end

    def submit!
      submissions.each { |s| s.submit! }
    end

    def submit
      submissions.each { |s| s.submit }
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
