module DynaForm
  module Macros
    include DynaForm::Constants

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
end
