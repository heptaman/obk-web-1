Admin.add 'OBK', 'Admin', 'admin@obk.org.au', '@dm1n08k'

v1 = Volunteer.add first_name: 'Mary', last_name: 'Anne', email: 'mary.anne@hotmail.com', mobile_number: '0451 601 804',
                   dob: Date.parse('1980-01-01'), password: 'asdfasdf', gender: 'F', wwccn: '123456', wwccn_status: 1
v2 = Volunteer.add first_name: 'Allan', last_name: 'Williams', email: 'allan.williams@gmail.com', mobile_number: '0403 356 164',
                   dob: Date.parse('1987-07-07'), password: 'asdfasdf', gender: 'M', wwccn: '987654', wwccn_status: 5,
                   wwccn_expiry_date: Time.zone.now + 4.years

e1 = Event.find_or_create_by! title: 'Challah party', description: 'Let''s eat bread, people!',
                              start: (Time.zone.now + 10.days).change(hour: 12, min: 0),
                              finish: (Time.zone.now + 10.days).change(hour: 14, min: 0),
                              min_volunteers: 2, max_volunteers: 10

e2 = Event.find_or_create_by! title: 'Cooking cookies', description: 'I''m the Cookie Monster!',
                              start: (Time.zone.now + 12.days).change(hour: 9, min: 0),
                              finish: (Time.zone.now + 12.days).change(hour: 16, min: 0),
                              min_volunteers: 3, max_volunteers: 7

e3 = Event.find_or_create_by! title: 'Birthday Party', description: 'Everyone is invited',
                              start: (Time.zone.now + 20.days).change(hour: 8, min: 0),
                              finish: (Time.zone.now + 20.days).change(hour: 12, min: 0),
                              min_volunteers: 2, max_volunteers: 5

e4 = Event.find_or_create_by! title: 'Something cool', description: 'Kool Aid for everybody!',
                              start: (Time.zone.now + 15.days).change(hour: 13, min: 0),
                              finish: (Time.zone.now + 20.days).change(hour: 17, min: 0),
                              min_volunteers: 5, max_volunteers: 20
e4.save(validate: false) if e4.new_record?

v1.events << e3

e1.volunteers << v1
e1.volunteers << v2
