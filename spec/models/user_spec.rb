require "rails_helper"

RSpec.describe User do
  it "requires an email and password" do
    user = User.new

    expect(user).not_to be_valid
    expect(user.errors[:email]).to include("can't be blank")
    expect(user.errors[:password]).to include("can't be blank")
  end

  it "authenticates using the stored password" do
    user = User.create!(email: "developer@example.com", password: "password", password_confirmation: "password")

    expect(user.valid_password?("password")).to be true
    expect(user.valid_password?("incorrect")).to be false
  end

  it "exposes projects through memberships" do
    membership = create(:membership)

    expect(membership.user.projects).to include(membership.project)
  end
end
