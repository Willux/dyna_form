require 'spec_helper'

describe DynaForm::Submission do
  describe "#submit" do
    let (:hypo_object) { OpenStruct.new }
    let (:variables) { [:first_name, :last_name] }
    let (:too_many_vars) { [:first_name, :last_name, :foo, :bar] }
    let (:attributes) { { :first_name => "Who", :last_name => "Cares", :foo => 42 } }

    context "given the model is in underscore style symbol" do
      it "should be able to properly parse the model name" do
        expect(Kernel).to receive(:const_get).with("AdminUser").and_raise("User created")
        submission = DynaForm::Submission.new(:admin_user, variables, attributes)
        expect { submission.submit }.to raise_error("User created")
      end
    end

    context "given the model is in underscore style string" do
      it "should be able to properly parse the model name" do
        expect(Kernel).to receive(:const_get).with("AdminUser").and_raise("User created")
        submission = DynaForm::Submission.new("admin_user", variables, attributes)
        expect { submission.submit }.to raise_error("User created")
      end
    end

    context "given the model is in camelcase style string" do
      it "should be able to properly parse the model name" do
        expect(Kernel).to receive(:const_get).with("AdminUser").and_raise("User created")
        submission = DynaForm::Submission.new("adminUser", variables, attributes)
        expect { submission.submit }.to raise_error("User created")
      end
    end

    context "given the model is in upper camelcase style string" do
      it "should be able to properly parse the model name" do
        expect(Kernel).to receive(:const_get).with("AdminUser").and_raise("User created")
        submission = DynaForm::Submission.new("AdminUser", variables, attributes)
        expect { submission.submit }.to raise_error("User created")
      end
    end

    context "given the variables we want to save" do
      it "should pick out the attributes based on the variable names" do
        attrs = { :first_name => "Who", :last_name => "Cares" }

        expect(Kernel).to receive(:const_get).with("AdminUser").and_return(hypo_object)
        expect(hypo_object).to receive(:create).with(attrs).and_raise("User created")

        submission = DynaForm::Submission.new(AdminUser, variables, attributes)
        expect { submission.submit }.to raise_error("User created")
      end      
    end

    context "given the number of variables outweighs the attributes" do
      it "should raise an error" do
        submission = DynaForm::Submission.new("admin_user", too_many_vars, attributes)
        expect { submission.submit }.to raise_error("Attempted to delegate a non-existed attribute variable")
      end
    end
  end
end
