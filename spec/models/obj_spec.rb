# frozen_string_literal: true
require "rails_helper"

RSpec.describe Obj, type: :model do
  let(:vocab) { Vocab.new prefix: "ex", uri: "http://example.org/" }
  subject(:obj) { Obj.new vocab: vocab, name: "Foo" }

  describe "#name" do
    it "has a name" do
      expect(obj.name).to eq("Foo")
    end
    it "can update the name" do
      obj.name = "Bar"
      expect(obj.name).to eq("Bar")
      expect(obj.to_s).to eq("ex:Bar")
    end
  end

  describe "#vocab" do
    it "belongs to a vocab" do
      expect(obj.vocab).to eq(vocab)
    end
  end

  describe "#to_s" do
    it "uses the vocab's prefix" do
      expect(obj.to_s).to eq("ex:Foo")
    end
  end

  describe "#valid?" do
    let(:bad_name) { Obj.new name: "", vocab: vocab }
    let(:bad_vocab) { Obj.new name: "foo", vocab: nil }

    it "has a valid name and vocab" do
      expect(obj).to be_valid
    end

    it "has to have a valid name" do
      expect(bad_name).not_to be_valid
    end

    it "has to have a valid vocab" do
      expect(bad_vocab).not_to be_valid
    end
  end
end
