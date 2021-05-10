# frozen_string_literal: true
require "rails_helper"

RSpec.describe Statement, type: :model do
  subject(:stmt) { Statement.new subject: sub, predicate: pre, literal: "foo" }
  let(:vocab) { Vocab.new prefix: "ex", uri: "http://example.org/" }
  let(:pre) { Predicate.new vocab: vocab, name: "title" }
  let(:sub) { Subject.new uri: "http://example.org/1" }
  let(:pre2) { Predicate.new vocab: vocab, name: "creator" }
  let(:sub2) { Subject.new uri: "http://example.org/2" }
  let(:obj) { Obj.new vocab: vocab, name: "Object" }

  describe "#subject" do
    it "has a subject" do
      expect(stmt.subject).to eq(sub)
    end
    it "can update the subject" do
      stmt.subject = sub2
      expect(stmt.subject).to eq(sub2)
    end
  end

  describe "#predicate" do
    it "has a predicate" do
      expect(stmt.predicate).to eq(pre)
    end
    it "can update the predicate" do
      stmt.predicate = pre2
      expect(stmt.predicate).to eq(pre2)
    end
  end

  describe "#statement_object" do
    it "auto-assigns based on type" do
      expect(stmt.statement_object).to eq("foo")

      stmt.statement_object = sub
      expect(stmt.statement_object).to eq(sub)
      expect(stmt.resource_object).to eq(sub)
      expect(stmt.literal).to be_nil
      expect(stmt.obj).to be_nil

      stmt.statement_object = obj
      expect(stmt.statement_object).to eq(obj)
      expect(stmt.obj).to eq(obj)
      expect(stmt.literal).to be_nil
      expect(stmt.resource_object).to be_nil

      stmt.statement_object = "bar"
      expect(stmt.statement_object).to eq("bar")
      expect(stmt.literal).to eq("bar")
      expect(stmt.obj).to be_nil
      expect(stmt.resource_object).to be_nil
    end
  end

  describe "#valid?" do
    let(:bad_sub) { Statement.new subject: nil, predicate: pre, literal: "foo" }
    let(:bad_pre) { Statement.new subject: sub, predicate: nil, literal: "foo" }
    let(:bad_lit) { Statement.new subject: sub, predicate: pre, literal: "" }
    let(:double1) { Statement.new subject: sub, predicate: pre, literal: "foo", resource_object: sub }
    let(:double2) { Statement.new subject: sub, predicate: pre, obj: obj, resource_object: sub }
    let(:double3) { Statement.new subject: sub, predicate: pre, obj: obj, literal: "foo" }

    it "has a valid subject, predicate, and literal" do
      expect(stmt).to be_valid
    end

    it "has to have a valid subject" do
      expect(bad_sub).not_to be_valid
    end

    it "has to have a valid predicate" do
      expect(bad_pre).not_to be_valid
    end

    it "has to have a valid literal" do
      expect(bad_lit).not_to be_valid
    end

    it "does not allow two different objects" do
      expect(double1).not_to be_valid
      expect(double2).not_to be_valid
      expect(double3).not_to be_valid
    end
  end
end
