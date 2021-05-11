require "rails_helper"

RSpec.describe ImportJob, type: :job do
  subject(:importer) { ImportJob }
  let(:file1) { Rails.root.join("spec", "fixtures", "file1.nt") }
  let(:file2) { Rails.root.join("spec", "fixtures", "file2.nt") }

  describe "#perform_now" do
    before do
      dct = Vocab.find_or_create_by(prefix: "dcterms", uri: "http://purl.org/dc/terms/")
      pcdm = Vocab.find_or_create_by(prefix: "pcdm", uri: "http://pcdm.org/models#")
      rdf = Vocab.find_or_create_by(prefix: "rdf", uri: "http://www.w3.org/1999/02/22-rdf-syntax-ns#")
      Subject.find_or_create_by(uri: "http://example.org/1")
      Predicate.find_or_create_by(vocab: rdf, name: "type")
      Predicate.find_or_create_by(vocab: dct, name: "title")
      Obj.find_or_create_by(vocab: pcdm, name: "Object")
    end

    it "imports and links to existing subjects and vocabularies" do
      expect { importer.perform_now(file1) }
         .to change { Subject.count }.by(0)
        .and change { Vocab.count }.by(0)
        .and change { Predicate.count }.by(0)
        .and change { Obj.count }.by(0)
    end
    it "imports and links to creates new subjects and vocabularies" do
      expect { importer.perform_now(file2) }
         .to change { Subject.count }.by(2)
        .and change { Vocab.count }.by(2)
        .and change { Predicate.count }.by(2)
        .and change { Obj.count }.by(1)
    end
  end
end
