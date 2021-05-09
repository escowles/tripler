# frozen_string_literal: true
require "rails_helper"

RSpec.describe Predicate, type: :model do
  let(:vocab) { Vocab.new prefix: "ex", uri: "http://example.org/" }
  subject(:pre) { Predicate.new vocab: vocab, name: "foo" }

  describe "#name" do
    it "has a name" do
      expect(pre.name).to eq("foo")
    end
    it "can update the name" do
      pre.name = "bar"
      expect(pre.name).to eq("bar")
      expect(pre.to_s).to eq("ex:bar")
    end
  end

  describe "#vocab" do
    it "belongs to a vocab" do
      expect(pre.vocab).to eq(vocab)
    end
  end

  describe "#to_s" do
    it "uses the vocab's prefix" do
      expect(pre.to_s).to eq("ex:foo")
    end
  end
end
