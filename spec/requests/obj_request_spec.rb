require "rails_helper"

RSpec.describe "Objs", type: :request do
  it "shows existing objects" do
    vocab = Vocab.create(prefix: "foo", uri: "http://example.org/foo#")
    obj1 = Obj.create(vocab: vocab, name: "obj1")
    obj2 = Obj.create(vocab: vocab, name: "obj2")

    get "/vocabs/#{vocab.id}/objs/"
    expect(response).to render_template(:index)
    expect(response.body).to include("obj1")
    expect(response.body).to include("obj2")

    # update a vocab and make sure it's updated
    put "/vocabs/#{vocab.id}/objs/#{obj2.id}", params: { obj: { vocab_id: vocab.id, name: "bar" } }
    follow_redirect!
    expect(response).to render_template(:show)
    expect(response.body).to include("obj1")
    expect(response.body).not_to include("obj2")
    expect(response.body).to include("bar")

    # delete a vocab and make sure it isn't listed
    delete "/vocabs/#{vocab.id}/objs/#{obj2.id}"
    get "/vocabs/#{vocab.id}/objs/"
    expect(response.body).to include("obj1")
    expect(response.body).not_to include("obj2")
    expect(response.body).not_to include("bar")
  end
end
