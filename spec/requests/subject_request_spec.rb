require "rails_helper"

RSpec.describe "Subjects", type: :request do
  it "shows existing subjects" do
    subj1 = Subject.create(uri: "http://example.org/1")
    subj2 = Subject.create(uri: "http://example.org/2")

    get "/subjects/"
    expect(response).to render_template(:index)
    expect(response.body).to include("http://example.org/1")
    expect(response.body).to include("http://example.org/2")

    # update a subject and make sure it's updated
    put "/subjects/#{subj2.id}", params: { subject: { uri: "http://example.org/foo" } }
    get "/subjects/"
    expect(response).to render_template(:index)
    expect(response.body).to include("http://example.org/1")
    expect(response.body).not_to include("http://example.org/2")
    expect(response.body).to include("http://example.org/foo")

    # delete a subject and make sure it isn't listed
    delete "/subjects/#{subj2.id}"
    follow_redirect!
    expect(response).to render_template(:index)
    expect(response.body).to include("http://example.org/1")
    expect(response.body).not_to include("http://example.org/2")
    expect(response.body).not_to include("http://example.org/foo")
  end
  it "creates a subject" do
    get "/subjects/new"
    expect(response).to render_template(:new)

    post "/subjects", params: { subject: { uri: "http://example.org/1" } }
    expect(response).to redirect_to(assigns(:subject))
    follow_redirect!

    expect(response).to render_template(:show)
    expect(response.body).to include("Subject was successfully created.")

    subject = Subject.first
    vocab = Vocab.create(prefix: "ex", uri: "http://example.org/")
    pred = Predicate.create(vocab: vocab, name: "foo")

    # create a statement
    get "/subjects/#{subject.id}/statements/new"
    expect(response).to render_template(:new)

    post "/subjects/#{subject.id}/statements", params: { statement: { subject_id: subject.id, predicate_id: pred.id, literal: "test object" } }
    expect(response).to redirect_to(assigns(:subject))
    follow_redirect!

    expect(response).to render_template(:show)
    expect(response.body).to include("Statement was successfully created.")

  end
end
