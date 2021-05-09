# frozen_string_literal: true
require "rails_helper"

RSpec.describe Subject, type: :model do
  subject(:subj) { Subject.new uri: "http://example.org/1" }

  describe "#statements" do
    let(:vocab) { Vocab.new prefix: "ex", uri: "http://example.org/" }
    let(:pre) { Predicate.new vocab: vocab, name: "title" }
    let(:stmt) { Statement.create! subject: subj, predicate: pre, literal: "foo" }
    before do
      stmt
    end

    it "has a statement" do
      expect(subj.statements).to eq([stmt])
    end
  end

  describe "#uri" do
    it "has a uri" do
      expect(subj.uri).to eq("http://example.org/1")
    end
    it "can update the uri" do
      subj.uri = "http://example.org/2"
      expect(subj.uri).to eq("http://example.org/2")
    end
  end
end
