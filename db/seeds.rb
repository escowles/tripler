vocabs = [
  {
    prefix: "dcterms",
    uri: "http://purl.org/dc/terms/",
    predicates: %W(abstract accessRights accrualMethod accrualPeriodicity accrualPolicy alternative audience available bibliographicCitation conformsTo contributor coverage created creator date dateAccepted dateCopyrighted dateSubmitted description educationLevel extent format hasFormat hasPart hasVersion identifier instructionalMethod isFormatOf isPartOf isReferencedBy isReplacedBy isRequiredBy issued isVersionOf language license mediator medium modified provenance publisher references relation replaces requires rights rightsHolder source spatial subject tableOfContents temporal title type valid),
    objects: %W(Agent AgentClass BibliographicResource FileFormat Frequency Jurisdiction LicenseDocument LinguisticSystem Location LocationPeriodOrJurisdiction MediaType MediaTypeOrExtent MethodOfAccrual MethodOfInstruction PeriodOfTime PhysicalMedium PhysicalResource Policy ProvenanceStatement RightsStatement SizeOrDuration Standard)
  },
  {
    prefix: "dctype",
    uri: "http://purl.org/dc/dcmitype/",
    predicates: [],
    objects: %W(Collection Dataset Event Image InteractiveResource MovingImage PhysicalObject Service Software Sound StillImage Text)
  },
  {
    prefix: "pcdm",
    uri: "http://pcdm.org/models#",
    predicates: %W(fileOf hasFile hasMember hasRelatedObject memberOf relatedObjectOf),
    objects: %W(AlternateOrder Collection File Object)
  },
  {
    prefix: "rdf",
    uri: "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
    predicates: %W(first rest type value),
    objects: %W(List nil)
  }
]

vocabs.each do |hsh|
  v = Vocab.find_or_create_by(prefix: hsh[:prefix], uri: hsh[:uri])
  hsh[:predicates].each do |p|
    Predicate.find_or_create_by(vocab: v, name: p)
  end
  hsh[:objects].each do |o|
    Obj.find_or_create_by(vocab: v, name: o)
  end
end
