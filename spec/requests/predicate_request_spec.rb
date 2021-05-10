require "rails_helper"

RSpec.describe "Predicates", type: :request do
  let(:vocab) { Vocab.create(prefix: "foo", uri: "http://example.org/foo#") }
  it "shows existing predicates" do
    pred1 = Predicate.create(vocab: vocab, name: "pred1")
    pred2 = Predicate.create(vocab: vocab, name: "pred2")

    get "/vocabs/#{vocab.id}/predicates/"
    expect(response).to render_template(:index)
    expect(response.body).to include("pred1")
    expect(response.body).to include("pred2")

    # update a vocab and make sure it's updated
    put "/vocabs/#{vocab.id}/predicates/#{pred2.id}", params: { predicate: { vocab_id: vocab.id, name: "bar" } }
    follow_redirect!
    expect(response).to render_template(:show)
    expect(response.body).to include("pred1")
    expect(response.body).not_to include("pred2")
    expect(response.body).to include("bar")

    # delete a vocab and make sure it isn't listed
    delete "/vocabs/#{vocab.id}/predicates/#{pred2.id}"
    get "/vocabs/#{vocab.id}/predicates/"
    expect(response.body).to include("pred1")
    expect(response.body).not_to include("pred2")
    expect(response.body).not_to include("bar")
  end
  it "does not create invalid predicates" do
    post "/vocabs/#{vocab.id}/predicates", params: { predicate: { vocab: vocab, name: "" } }
    expect(response).to have_http_status(:unprocessable_entity)
    expect(response).to render_template(:new)
  end
  it "does not update predicates to be invalid" do
    pre = Predicate.create(vocab: vocab, name: "foo")
    put "/vocabs/#{vocab.id}/predicates/#{pre.id}", params: { predicate: { vocab: vocab, name: "" } }
    expect(response).to have_http_status(:unprocessable_entity)
    expect(response).to render_template(:edit)
  end
end
