admin_role = UserRole.create(role_name: 'admin')
user_role = UserRole.create(role_name: 'user')

Region.create(:name => 'Constellation')
region = Region.create(:name => 'North Oaken')
Region.create(:name => 'South Oaken')
Region.create(:name => 'Midlands')
Region.create(:name => 'Pentamere')
Region.create(:name => 'Out of Kingdom')

User.create(
  :email => 'admin@test.com',
  :password => 'adminadmin',
  :password_confirmation => 'adminadmin',
  user_role: admin_role,
  region: region,
  confirmed_at: DateTime.now)
User.create(
  :email => 'user@test.com',
  :password => 'useruser',
  :password_confirmation => 'useruser',
  user_role: user_role,
  region: region,
  confirmed_at: DateTime.now)

Fair.create(date: Date.today, region: region, name: 'Generic Fair', internet_access: true)

Timeslot.create(order: 1, description: 'Section 1')
Timeslot.create(order: 2, description: 'Section 2')
Timeslot.create(order: 3, description: 'Section 3')
Timeslot.create(order: 4, description: 'Section 4')
Timeslot.create(order: 5, description: 'Section 5')

performance = Division.create(:name => 'Div 1 Performance Arts')
Division.create(:name => 'Div 2 Textile Arts')
Division.create(:name => 'Div 3 Technical Arts')
studio = Division.create(:name => 'Div 4 Studio Arts')
Division.create(:name => 'Div 5 Domestic Arts')

Category.create(:name => 'Dance Performance', division: performance,
                description: "The purpose of this category is to judge the performance of a dance from before 1600 C.E., or a dance in a pre-17th-c. style. The category includes improvised dances such as galliards or saltarelli, and choreographed dances. The performance may employ one or more dancers. Groups of performers will be evaluated as a single ensemble unless one or more entrants wish to be judged as individuals; in this case, individual entrants will register for the competition as separate entries and will remind the judges that they are to be scored individually. Individual entrants will be judged on their own performances only; any other performer is not scored, except as it directly impacts the entrant's performance. While live music is preferred, entrants will not be marked down for using recorded music as long as the recording is appropriate for the dance. A copy of the documentation must be provided to each judge. (See below for desired content.) For all performance entries, event staff will make every effort to provide a performance space that allows audience members to attend. The performance venue should be quiet and spacious enough for performances to take place (with high enough ceilings, if needed). It should also be clear of impediments such as furniture, stairs, and other items that could make performance dangerous. Performances that involve potentially dangerous materials, such as fire, should be provided performance space outdoors. Any entry that exhibits danger to the entrant(s), judges, or audience will be immediately disqualified. The performance may be no longer than 15 minutes. Performers may present excerpts or abridgements of a longer dance in order to comply with this time limit.")

docs = CriteriaType.create(description: 'Documentation', max_score: 4)
CriteriaType.create(description: 'Methods and Materials', max_score: 4)
CriteriaType.create(description: 'Scope', max_score: 6)
CriteriaType.create(description: 'Skill', max_score: 6)
CriteriaType.create(description: 'Creativity', max_score: 4)
CriteriaType.create(description: "Judge's Observation", max_score: 4)

CriteriaDescription.create(criteria_type_id: docs.id, category_id: performance.id,
                           description: "This primarily concerns performance of footwork and general use of the body in dance, as well as a defense of the reconstruction or choreography if applicable. For full points, the documentation must include the style of dance to which the entry belongs, the time(s) and place(s) that style was used, and the dance’s societal context (i.e., where it would have been performed, by whom, under what circumstances, for what purpose, etc.). It should also include a discussion of performance practices as they relate to the relevant historical period(s). It should also include a discussion of the piece’s difficulty as per the Scope category (see below). The judges must be provided with instructions for the dance, including expected floor patterns and descriptions of steps. This may include descriptions of footwork, reconstructions, or original choreography. Potential floor patterns should also be discussed.")

Criterium.create(optional: false, animal: false, suggested_score: 0, criteria_type_id: docs.id, category_id: performance.id,
                 description: "No documentation provided with entry. Face-to-face judging adds very little information.")

Criterium.create(optional: false, animal: false, suggested_score: 1, criteria_type_id: docs.id, category_id: performance.id,
                 description: "Minimal information is provided for time, place and style. Face-to-face judging adds some background information.")
