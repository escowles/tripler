class Subject < ApplicationRecord
  has_many :statements, dependent: :destroy

  validates :uri, presence: true
  validates :uri, format: { with: URI.regexp }, if: :present?

  def to_s
    uri
  end

  def to_rdf
    graph = RDF::Graph.new
    statements.each do |s|
      obj = s.statement_object
      obj = RDF::URI(obj.uri) unless obj.is_a?(String)
      graph << [RDF::URI(s.subject.uri), RDF::URI(s.predicate.uri), obj]
    end
    graph.dump(:ntriples).to_s
  end
end
