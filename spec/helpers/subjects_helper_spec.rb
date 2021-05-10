# frozen_string_literal: true
require "rails_helper"

RSpec.describe SubjectsHelper, type: :helper do
  let(:sub) { Subject.create uri: "http://example.org/1" }
  let(:voc) { Vocab.new prefix: "ex", uri: "http://example.org/" }
  let(:obj) { Obj.new vocab: voc, name: "Foo" }

  describe "#format_object" do
    it "quotes literals" do
      expect(helper.format_object("foo")).to eq("\"foo\"")
    end

    it "brackets and linkifies URIs" do
      expect(helper.format_object(sub)).to eq("&lt;<a href=\"/subjects/1\">http://example.org/1</a>&gt;")
    end

    it "formats Objs as short names" do
      expect(helper.format_object(obj)).to eq("ex:Foo")
    end
  end
end
