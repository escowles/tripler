require "rails_helper"

RSpec.describe "Vocabs", type: :request do
  it "shows existing vocabs" do
    vocab1 = Vocab.create(prefix: "foo", uri: "http://example.org/foo#")
    vocab2 = Vocab.create(prefix: "bar", uri: "http://example.org/bar#")

    get "/vocabs/"
    expect(response.body).to include("foo")
    expect(response.body).to include("bar")

    # update a vocab and make sure it's updated
    put "/vocabs/#{vocab2.id}", params: { vocab: { prefix: "baz", uri: "http://example.org/baz#" } }
    get "/vocabs/"
    expect(response).to render_template(:index)
    expect(response.body).to include("foo")
    expect(response.body).not_to include("bar")
    expect(response.body).to include("baz")

    # delete a vocab and make sure it isn't listed
    delete "/vocabs/#{vocab2.id}"
    follow_redirect!
    expect(response).to render_template(:index)
    expect(response.body).to include("foo")
    expect(response.body).not_to include("bar")
    expect(response.body).not_to include("baz")
  end
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
