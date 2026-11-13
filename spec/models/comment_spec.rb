require "rails_helper"

RSpec.describe Comment do
  it "requires a user and a bug" do
    comment_without_user = Comment.new(bug: create(:bug))
    comment_without_bug = Comment.new(user: create(:user))

    expect(comment_without_user).not_to be_valid
    expect(comment_without_user.errors[:user]).to include("must exist")
    expect(comment_without_bug).not_to be_valid
    expect(comment_without_bug.errors[:bug]).to include("must exist")
  end

  it "allows multiple comments for the same user and bug" do
    user = create(:user)
    bug = create(:bug)
    comments = [
      create(:comment, user:, bug:),
      create(:comment, user:, bug:)
    ]

    expect(user.comments).to match_array(comments)
    expect(bug.comments).to match_array(comments)
  end
end
