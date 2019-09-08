admin_role = UserRole.create(role_name: "admin")
user_role = UserRole.create(role_name: "user")

User.create(:email => "admin@test.com", :password => "adminadmin", :password_confirmation => "adminadmin", user_role: admin_role)
User.create(:email => "user@test.com", :password => "useruser", :password_confirmation => "useruser", user_role: user_role)
