admin_role = UserRole.create(role_name: 'admin')
user_role = UserRole.create(role_name: 'user')

Region.create(:name => 'Constellation')
region = Region.create(:name => 'North Oaken')
Region.create(:name => 'South Oaken')
Region.create(:name => 'Midlands')
Region.create(:name => 'Pentamere')
Region.create(:name => 'Out of Kingdom')

User.create(:email => 'admin@test.com', :password => 'adminadmin', :password_confirmation => 'adminadmin', user_role: admin_role, region: region)
User.create(:email => 'user@test.com', :password => 'useruser', :password_confirmation => 'useruser', user_role: user_role, region: region)

Division.create(:name => 'Div 1 Performance Arts')
Division.create(:name => 'Div 2 Textile Arts')
Division.create(:name => 'Div 3 Technical Arts')
studio = Division.create(:name => 'Div 4 Studio Arts')
Division.create(:name => 'Div 5 Domestic Arts')

Category.create(:name => 'Scribal', division: studio)
Category.create(:name => 'Leatherwork', division: studio)

Fair.create(date: Date.today, region:region)

Timeslot.create(order: 1, description: 'Section 1')
Timeslot.create(order: 2, description: 'Section 2')
Timeslot.create(order: 3, description: 'Section 3')
Timeslot.create(order: 4, description: 'Section 4')
Timeslot.create(order: 5, description: 'Section 5')
