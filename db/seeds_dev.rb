admin_role = UserRole.create(role_name: 'admin')
user_role = UserRole.create(role_name: 'user')

Region.create(name: 'Constellation')
region = Region.create(name: 'North Oaken')
Region.create(name: 'South Oaken')
Region.create(name: 'Midlands')
Region.create(name: 'Pentamere')
Region.create(name: 'Out of Kingdom')

admin = User.create(
    :email => 'admin@test.com',
    :password => 'adminadmin',
    :password_confirmation => 'adminadmin',
    user_role: admin_role,
    sca_name: 'Admin',
    region: region,
    confirmed_at: DateTime.now)
user = User.create(
    :email => 'user@test.com',
    :password => 'useruser',
    :password_confirmation => 'useruser',
    user_role: user_role,
    sca_name: 'User',
    region: region,
    confirmed_at: DateTime.now)

fair = Fair.create(date: Date.today, region: region, name: 'Generic Fair', internet_access: true)

Timeslot.create(order: 1, description: 'Section 1')
Timeslot.create(order: 2, description: 'Section 2')
Timeslot.create(order: 3, description: 'Section 3')
Timeslot.create(order: 4, description: 'Section 4')
Timeslot.create(order: 5, description: 'Section 5')

div1 = Division.create(name: "Div 1")
div2 = Division.create(name: "Div 2")
div3 = Division.create(name: "Div 3")
div4 = Division.create(name: "Div 4")
div5 = Division.create(name: "Div 5")

CriteriaType.create(description: 'Research and Supporting Evidence', max_score: 4)
CriteriaType.create(description: 'Materials and Methods', max_score: 4)
CriteriaType.create(description: 'Scope', max_score: 6)
CriteriaType.create(description: 'Skill', max_score: 6)
CriteriaType.create(description: 'Ingenuity', max_score: 4)
CriteriaType.create(description: "Judge's Observation", max_score: 4)

entry = Entry.create(entry_name: 'test entry 1', description: 'test entry 1 description', division_id: div1.id, fair_id: fair.id)
JudgeAssign.create(user_id: admin.id, entry_id: entry.id)
UserEntry.create(entry_id: entry.id, user_id: admin.id)

entry_2 = Entry.create(entry_name: 'test entry 2', description: 'test entry 2 description', division_id: div2.id, fair_id: fair.id)
UserEntry.create(entry_id: entry.id, user_id: user.id)

pent1 = Entry.create(entry_name: 'pent1', description: 'description', division_id: div1.id, fair_id: fair.id, pentathlon: true)
JudgeAssign.create(user_id: admin.id, entry_id: pent1.id)
UserEntry.create(entry_id: pent1.id, user_id: admin.id)

pent2 = Entry.create(entry_name: 'pent2', description: 'description', division_id: div2.id, fair_id: fair.id, pentathlon: true)
JudgeAssign.create(user_id: admin.id, entry_id: pent2.id)
UserEntry.create(entry_id: pent2.id, user_id: admin.id)

pent3 = Entry.create(entry_name: 'pent3', description: 'description', division_id: div3.id, fair_id: fair.id, pentathlon: true)
JudgeAssign.create(user_id: admin.id, entry_id: pent3.id)
UserEntry.create(entry_id: pent3.id, user_id: admin.id)

pent4 = Entry.create(entry_name: 'pent4', description: 'description', division_id: div4.id, fair_id: fair.id, pentathlon: true)
JudgeAssign.create(user_id: admin.id, entry_id: pent4.id)
UserEntry.create(entry_id: pent4.id, user_id: admin.id)

pent5 = Entry.create(entry_name: 'pent5', description: 'description', division_id: div5.id, fair_id: fair.id, pentathlon: true)
JudgeAssign.create(user_id: admin.id, entry_id: pent5.id)
UserEntry.create(entry_id: pent5.id, user_id: admin.id)

div1 = Entry.create(entry_name: 'div1', description: 'description', division_id: div1.id, fair_id: fair.id, division_type: true)
JudgeAssign.create(user_id: admin.id, entry_id: div1.id)
UserEntry.create(entry_id: div1.id, user_id: admin.id)

div2 = Entry.create(entry_name: 'div2', description: 'description', division_id: div2.id, fair_id: fair.id, division_type: true)
JudgeAssign.create(user_id: admin.id, entry_id: div2.id)
UserEntry.create(entry_id: div2.id, user_id: admin.id)

div3 = Entry.create(entry_name: 'div3', description: 'description', division_id: div3.id, fair_id: fair.id, division_type: true)
JudgeAssign.create(user_id: admin.id, entry_id: div3.id)
UserEntry.create(entry_id: div3.id, user_id: admin.id)

div4 = Entry.create(entry_name: 'div4', description: 'description', division_id: div4.id, fair_id: fair.id, division_type: true)
JudgeAssign.create(user_id: admin.id, entry_id: div4.id)
UserEntry.create(entry_id: div4.id, user_id: admin.id)

Location.create(description: 'Room 1', fair_id: fair.id)
Location.create(description: 'Room 2', fair_id: fair.id)

JudgeFair.create(fair_id: fair.id, user_id: user.id)
JudgeFair.create(fair_id: fair.id, user_id: admin.id)
