require "rails_helper"

RSpec.describe "Subjects", type: :request do
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
