require "rails_helper"

RSpec.describe "Vocabs", type: :request do
  it "creates a vocab and adds predicates and objects" do
    get "/vocabs/new"
    expect(response).to render_template(:new)

    post "/vocabs", params: { vocab: { prefix: "ex", uri: "http://example.org/" } }
    expect(response).to redirect_to(assigns(:vocab))
    follow_redirect!

    expect(response).to render_template(:show)
    expect(response.body).to include("Vocab was successfully created.")

    vocab = Vocab.first

    # create a predicate
    get "/vocabs/#{vocab.id}/predicates/new"
    expect(response).to render_template(:new)

    post "/vocabs/#{vocab.id}/predicates", params: { predicate: { vocab_id: vocab.id, name: "foo" } }
    expect(response).to redirect_to(assigns(:vocab))
    follow_redirect!

    expect(response).to render_template(:show)
    expect(response.body).to include("Predicate was successfully created.")

    # create an object
    get "/vocabs/#{vocab.id}/objs/new"
    expect(response).to render_template(:new)

    post "/vocabs/#{vocab.id}/objs", params: { obj: { vocab_id: vocab.id, name: "Bar" } }
    expect(response).to redirect_to(assigns(:vocab))
    follow_redirect!

    expect(response).to render_template(:show)
    expect(response.body).to include("Obj was successfully created.")
  end
end
