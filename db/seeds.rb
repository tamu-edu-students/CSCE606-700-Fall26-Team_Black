# Obviously unsecure. For developement use only.
User.find_or_create_by!(email: "kiefercrowley@tamu.edu") do |u|
  u.username = "Mr.Crowley"
  u.name = "Kiefer Crowley"
  u.password = "password123"
  u.password_confirmation = "password123"
  u.role = "admin"
end
User.find_or_create_by!(email: "jiaruifu@tamu.edu") do |u|
  u.username = "f_testing"
  u.name = "Oops I forgot my password"
  u.password = "password123"
  u.password_confirmation = "password123"
  u.role = "user"
end

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

new_users = [
    { username: 'bossman', name: 'I. M. Boss', password: 'password123', password_confirmation: 'password123', role: 'user', email: 'bossman@raid.com' },
    { username: 'teamleader', name: 'Mike R. Manager', password: 'password123', password_confirmation: 'password123', role: 'user', email: 'leader@raid.com' },
    { username: 'bootdev', name: 'L. O. Dev', password: 'password123', password_confirmation: 'password123', role: 'user', email: 'boot@raid.com' }
]

new_projects = [
    { name: 'R@1D' },
    { name: 'Rubikey' }
]

new_bugs = [
    { title: 'Nothing Works',
      description: 'Literaly nothing works',
      replication: 'Steps on how to replicate',
      priority: 'urgent',
      status: 'open' },
    { title: 'No login',
      description: 'I cant login!',
      replication: 'Steps on how to replicate',
      priority: 'high',
      status: 'inprogress' },
    { title: 'Cant submit a bug',
      description: 'I need to submit a bug',
      replication: 'Steps on how to replicate',
      priority: 'medium',
      status: 'open' }
]

new_comments = [
    { comment: 'This bug is really annoying', created_at: Time.utc(2026, 11, 1, 9, 0) },
    { comment: 'I dont know why this is happening', created_at: Time.utc(2026, 11, 1, 10, 0) },
    { comment: 'Can someone look into this?', created_at: Time.utc(2026, 11, 1, 11, 0) },
    { comment: 'Is anyone working on this bug?', created_at: Time.utc(2026, 11, 1, 12, 0) },
    { comment: 'We should close this bug as its a duplicate.', created_at: Time.utc(2026, 11, 1, 13, 0) }
]

new_users.each do |user|
    User.create!(user) if User.where(username: user[:username]).empty?
end

p User.all

new_projects.each do |project|
    if Project.where(name: project[:name]).empty?
        pro = Project.new(project)
        pro.owner = User.where(username: 'teamleader').first
        pro.save
    end
end

p Project.all

new_bugs.each do |bug|
    if Bug.where(title: bug[:title]).empty?
        n_bug = Bug.new(bug)
        n_bug.project = Project.where(name: 'R@1D').first
        n_bug.user = User.all.sample
        n_bug.save
    end
end

p Bug.all

bug = Bug.find_by!(title: 'Nothing Works')

new_comments.each do |comment_attributes|
    n_comment = Comment.find_or_initialize_by(comment: comment_attributes[:comment])
    n_comment.bug = bug
    n_comment.user ||= User.all.sample
    n_comment.created_at = comment_attributes[:created_at]
    n_comment.save!
end

p Comment.all
