FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    sequence(:username) { |n| "user#{n}" }
    name { "Test User" }
    password { "password" }
  end

  factory :project do
    name { "Project" }
    owner factory: :user

    # Mirrors ProjectsController#create, which makes the creator an admin member.
    after(:create) do |project|
      project.memberships.create!(user: project.owner, role: "admin")
    end
  end

  factory :membership do
    user
    project
    role { "developer" }
  end

  factory :bug do
    title { "Something is broken" }
    status { "open" }
    priority { "low" }
    project
    user
  end

  factory :comment do
    comment { "I can reproduce this" }
    bug
    user
  end
end
