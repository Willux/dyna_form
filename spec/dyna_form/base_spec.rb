require 'spec_helper'

describe DynaForm::Base do
  describe ".new" do
    let(:base) { DynaForm::Base.new(var: "good", life: 42, "foo" => :bar)}

    it "should create instance variables based on the arguments" do
      expect(base.var).to eq("good")
      expect(base.life).to eq(42)
      expect(base.foo).to eq(:bar)
    end

    context "given that the argument hash is not empty" do
      it "should not allow to initialize another instance variable" do
        expect { base.new_var = "good" }.to raise_error(NoMethodError)
      end
    end

    context "given that the argument has is empty" do
      it "should allow to initialize any other instance variables" do
        empty_base = DynaForm::Base.new
        empty_base.new_var = :foo
        empty_base.new_var_again = 42

        expect(empty_base.new_var).to eq(:foo)
        expect(empty_base.new_var_again).to eq(42)
      end
    end
  end

  describe ".submit" do
    it "should return the fields associated with a given class" do
      fields = TestForm.class_variable_get(:@@fields)
      expect(fields).to have_key("AdminUser")
      expect(fields).to have_key("Nobody")

      expect(fields["AdminUser"] - [:first_name, :last_name]).to eq([])
      expect(fields["Nobody"] - [:who_cares]).to eq([])
    end

    context "given that the same model is used in different instances" do
      it "should merge the fields of the same model" do
        fields = TestFormAgain.class_variable_get(:@@fields)
        expect(fields).to have_key("AdminUser")

        expect(fields["AdminUser"] - [:middle_name, :nickname, :permissions, :awesomness]).to eq([])
      end
    end
  end

  describe "#submit" do
    
  end

end
