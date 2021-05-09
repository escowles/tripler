# frozen_string_literal: true
require "rails_helper"

RSpec.describe Vocab, type: :model do
  subject(:vocab) { Vocab.new prefix: "ex", uri: "http://example.org/" }

  describe "#objs" do
    let(:obj) { Obj.create! vocab: vocab, name: "Bar" }
    before do
      obj
    end

    it "has an object" do
      expect(vocab.objs).to eq([obj])
    end
  end

  describe "#predicates" do
    let(:pre) { Predicate.create! vocab: vocab, name: "foo" }
    before do
      pre
    end

    it "has a predicate" do
      expect(vocab.predicates).to eq([pre])
    end
  end

  describe "#prefix" do
    it "has a prefix" do
      expect(vocab.prefix).to eq("ex")
    end
    it "can update the prefix" do
      vocab.prefix = "example"
      expect(vocab.prefix).to eq("example")
    end
  end

  describe "#uri" do
    it "has a uri" do
      expect(vocab.uri).to eq("http://example.org/")
    end
    it "can update the uri" do
      vocab.uri = "http://example.org/foo#"
      expect(vocab.uri).to eq("http://example.org/foo#")
    end
  end
end
