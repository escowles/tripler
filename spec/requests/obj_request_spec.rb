require "rails_helper"

RSpec.describe "Objs", type: :request do
  let(:vocab) { Vocab.create(prefix: "foo", uri: "http://example.org/foo#") }
  it "shows existing objects" do
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
  it "does not create invalid objects" do
    post "/vocabs/#{vocab.id}/objs", params: { obj: { vocab: vocab, name: "" } }
    expect(response).to have_http_status(:unprocessable_entity)
    expect(response).to render_template(:new)
  end
  it "does not update objects to be invalid" do
    obj = Obj.create(vocab: vocab, name: "foo")
    put "/vocabs/#{vocab.id}/objs/#{obj.id}", params: { obj: { vocab: vocab, name: "" } }
    expect(response).to have_http_status(:unprocessable_entity)
    expect(response).to render_template(:edit)
  end
end
