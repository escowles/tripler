require "rails_helper"

RSpec.describe "Statements", type: :request do
  it "shows existing statements" do
    subj = Subject.create(uri: "http://example.org/resources/1")
    vocab = Vocab.create(prefix: "ex", uri: "http://example.org/vocab/")
    pred1 = Predicate.create(vocab: vocab, name: "foo")
    pred2 = Predicate.create(vocab: vocab, name: "bar")
    pred3 = Predicate.create(vocab: vocab, name: "baz")
    stmt1 = Statement.create(subject: subj, predicate: pred1, literal: "value1")
    stmt2 = Statement.create(subject: subj, predicate: pred2, literal: "value2")

    get "/subjects/#{subj.id}/statements/"
    expect(response).to render_template(:index)
    expect(response.body).to include("ex:foo")
    expect(response.body).to include("value1")
    expect(response.body).to include("ex:bar")
    expect(response.body).to include("value2")
    expect(response.body).not_to include("ex:baz")
    expect(response.body).not_to include("value3")

    # update a statement and make sure it's updated
    put "/subjects/#{subj.id}/statements/#{stmt2.id}", params: { statement: { predicate_id: pred3.id, literal: "value3" } }
    follow_redirect!
    expect(response).to render_template(:show)
    expect(response.body).to include("ex:foo")
    expect(response.body).to include("value1")
    expect(response.body).not_to include("ex:bar")
    expect(response.body).not_to include("value2")
    expect(response.body).to include("ex:baz")
    expect(response.body).to include("value3")

    # delete a vocab and make sure it isn't listed
    delete "/subjects/#{subj.id}/statements/#{stmt2.id}"
    get "/subjects/#{subj.id}/statements/"
    expect(response.body).to include("ex:foo")
    expect(response.body).to include("value1")
    expect(response.body).not_to include("ex:bar")
    expect(response.body).not_to include("value2")
    expect(response.body).not_to include("ex:baz")
    expect(response.body).not_to include("value3")
  end
end
