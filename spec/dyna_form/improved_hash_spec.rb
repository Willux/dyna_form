require 'spec_helper'

describe DynaForm::ImprovedHash do
  describe "#[]" do
    let(:hsh) { DynaForm::ImprovedHash.new }
    context "given that I pass a float as a key" do
      it "should return by string and float key" do
        hsh[4.2] = "Test"
        expect(hsh[4.2]).to eq("Test")
        expect(hsh["4.2"]).to eq("Test")
      end
    end

    context "given that I pass an integer as a key" do
      it "should return by string and integer key" do
        hsh[5] = "Test"
        expect(hsh[5]).to eq("Test")
        expect(hsh["5"]).to eq("Test")
      end
    end

    context "given that I pass a TrueClass object as a key" do
      it "should return by string and TrueClass key" do
        hsh[true] = "Test"
        expect(hsh[true]).to eq("Test")
        expect(hsh["true"]).to eq("Test")
      end
    end

    context "given that I pass a FalseClass object as a key" do
      it "should return by string and FalseClass key" do
        hsh[false] = "Test"
        expect(hsh[false]).to eq("Test")
        expect(hsh["false"]).to eq("Test")
      end
    end

    context "given that I pass a Symbol object as a key" do
      it "should return by string and Symbol key" do
        hsh[:key] = "Test"
        expect(hsh[:key]).to eq("Test")
        expect(hsh["key"]).to eq("Test")
      end
    end
  end
end
