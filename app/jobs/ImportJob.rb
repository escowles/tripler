require "rdf"

class ImportJob < ApplicationJob
  def perform(filename)
    RDF::NTriples::Reader.open(filename) do |reader|
      reader.each_statement do |stmt|
        import_statement(stmt)
      end
    end
  end

  def import_statement(stmt)
    sub = Subject.find_or_create_by(uri: stmt.subject.to_s)
    pre = find_or_create_predicate(stmt.predicate.to_s)
    if stmt.object.literal?
      Statement.create(subject: sub, predicate: pre, literal: stmt.object)
    else
      obj = find_or_create_object(stmt.object.to_s)
      if obj.is_a?(Obj)
        Statement.create(subject: sub, predicate: pre, obj: obj)
      else
        Statement.create(subject: sub, predicate: pre, resource_object: obj)
      end
    end
  end

  def find_or_create_predicate(uri)
    pre_arr = parse_uri(uri)
    voc = Vocab.find_by(uri: pre_arr[0]) || Vocab.create(uri: pre_arr[0], prefix: random_prefix)
    Predicate.find_or_create_by(vocab: voc, name: pre_arr[1])
  end

  def find_or_create_object(uri)
    obj_arr = parse_uri(uri)
    voc = Vocab.find_by(uri: obj_arr[0])
    return Obj.find_or_create_by(vocab: voc, name: obj_arr[1]) if voc
      
    # if the vocab doesn't exist, assume we should create a subject
    Subject.find_or_create_by(uri: uri)
  end

  def parse_uri(uri)
    uri.match(/(^.*[\#\/])(.+)/) { |m| [m[1], m[2]] }
  end

  def random_prefix
    "ns#{SecureRandom.urlsafe_base64(6)}"
  end
end
