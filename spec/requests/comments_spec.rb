require "rails_helper"

RSpec.describe "Comments", type: :request do
  describe "POST /bugs/:bug_id/comments" do
    let(:user) { create(:user) }
    let(:bug) { create(:bug) }

    before { sign_in user }

    it "creates a comment for the bug and attributes it to the current user" do
      expect {
        post bug_comments_path(bug), params: { comment: { comment: "I can reproduce this" } }
      }.to change(Comment, :count).by(1)

      comment = Comment.last
      expect(comment.bug).to eq(bug)
      expect(comment.user).to eq(user)
      expect(response).to redirect_to(bug_path(bug))
    end

    it "does not create a blank comment" do
      expect {
        post bug_comments_path(bug), params: { comment: { comment: "" } }
      }.not_to change(Comment, :count)

      expect(response).to redirect_to(bug_path(bug))
    end

    it "does not create a whitespace-only comment" do
      expect {
        post bug_comments_path(bug), params: { comment: { comment: "   " } }
      }.not_to change(Comment, :count)

      expect(response).to redirect_to(bug_path(bug))
    end
  end
end
