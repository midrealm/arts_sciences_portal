admin_role = UserRole.create(role_name: 'admin')
user_role = UserRole.create(role_name: 'user')

User.create(:email => 'admin@test.com', :password => 'adminadmin', :password_confirmation => 'adminadmin', user_role: admin_role)
User.create(:email => 'user@test.com', :password => 'useruser', :password_confirmation => 'useruser', user_role: user_role)

Division.create(:name => 'Div 1 Performance Arts')
Division.create(:name => 'Div 2 Textile Arts')
Division.create(:name => 'Div 3 Technical Arts')
studio = Division.create(:name => 'Div 4 Studio Arts')
Division.create(:name => 'Div 5 Domestic Arts')

Category.create(:name => 'Scribal', division: studio)
Category.create(:name => 'Leatherwork', division: studio)
