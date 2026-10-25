# Obviously unsecure. For developement use only. 
User.find_or_create_by!(email: "kiefercrowley@tamu.edu") do |u|
  u.password = "password123"
  u.password_confirmation = "password123"
  u.role = "admin"
end