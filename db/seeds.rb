# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#User Levels
# UserLevel.create!(name: 'Not Defined')
# UserLevel.create!(name: 'Finance')
# UserLevel.create!(name: 'Program Coordinator')
# UserLevel.create!(name: 'Manager')
# UserLevel.create!(name: 'Marketing')
# UserLevel.create!(name: 'CEO')

# usr = User.create!(name:  "Admin User",
#              email: "example@example.com",
#              password: "foobar311",
#              admin: true,
#              is_staff: true,
#               roles: [:admin]
#              )
#
# User.update(usr.id, :confirmation_token => nil, :confirmed_at => DateTime.now)

roles = [:superadmin, :ceo, :program_coordinator, :finance, :manager, :staff, :admin, :guest]

roles.each do |role|
  usr = User.create!(name:  "#{role.to_s.humanize} User",
                       email: "#{role.to_s}@example.com",
                       password: "foobar311",
                       admin: true,
                       is_staff: true,
                       roles: [role])
  User.update(usr.id, :confirmation_token => nil, :confirmed_at => DateTime.now)
  pd = usr.build_profile_personal_detail
  pd.update(:first_name => Faker::Name.first_name, :other_names => Faker::Name.last_name, :sex => "Female", :nationality => "Ugandan")
  gd = usr.build_profile_general_detail
  gd.update(:title => Faker::Name.title, :education => Faker::Lorem.words(num=3),
            :staff_id => Faker::Lorem.characters(9), :date_hired =>Faker::Date.backward(days=453), :salary => Faker::Number.between(1000, 5000))
  cd = usr.build_profile_contact_detail
  cd.update(:address => Faker::Address.street_address, :mobile_phone => Faker::PhoneNumber.cell_phone)
  bd = usr.build_profile_bank_detail
  bd.update(:bank_details => Faker::Hipster.sentence)
end

# 2.times do |n|
#   name  = Faker::Name.name
#   email = "example-#{n+1}@example.com"
#   password = "password"
#   User.create!(name:  name,
#                email: email,
#                password: password,
#                is_staff: true,
#                 roles: [:staff])
# end

countries = [
  ["Uganda", "UG", 256],
  ["Kenya", "KE", 254],
  ["Tanzania", "TZ", 255],
  ["Rwanda", "RW", 256],
  ["Burundi", "BU", 257]]


countries.each do |country|
  name = country[0]
  c_code = country[1]
  telephone_code = country[2]
  Country.create!(name: name,
                  c_code: c_code,
                  telephone_code: telephone_code
                  )
end

#Program types
Category.create!(name: 'Open Program')
Category.create!(name: 'Tailor made Training')
Category.create!(name: 'Workshop')
Category.create!(name: 'Conference')
Category.create!(name: 'Study Tour')

today = Date.today
ProgramDate.create!(start_date: today, end_date: today + 3.week)
ProgramDate.create!(start_date: today + 2.month, end_date: today + 2.month + 3.week)
ProgramDate.create!(start_date: today + 6.month, end_date: today + 6.month + 3.week)

ProgramVenue.create!(name: "Kampala", country: Country.find_by(name: "Uganda"))
ProgramVenue.create!(name: "Dar es Salam", country: Country.find_by(name: "Tanzania"))
ProgramVenue.create!(name: "Nairobi", country: Country.find_by(name: "Kenya"))
ProgramVenue.create!(name: "Kigali", country: Country.find_by(name: "Rwanda"))

Program.create!(name: "Skills Enhancement Programme For Executive Secretaries and Administrative / Personal Assistants",
category: Category.find(1),
description: "The role of the Secretary, Personal Assistant and other Administrative Professionals has undergone remarkable transformation and global trends continue to shape this profession.",
is_service: true
)

Program.create!(name: "Project management skills executive secretaries",
category: Category.find(1),
description: "This project management course will take place bla bla bla. The role of the Secretary, Personal Assistant and other Administrative Professionals has undergone remarkable transformation and global trends continue to shape this profession.",
is_service: true
)

p = Program.first
p.programdates = [ProgramDate.find(1), ProgramDate.find(2), ProgramDate.find(3)]
p.programvenues = [ProgramVenue.find(1), ProgramVenue.find(2), ProgramVenue.find(3)]

p2 = Program.find(2)
p2.programdates = [ProgramDate.find(1), ProgramDate.find(2), ProgramDate.find(3)]
p2.programvenues = [ProgramVenue.find(1), ProgramVenue.find(2), ProgramVenue.find(3)]

OpportunityStatus.create(name: 'Proposal')
OpportunityStatus.create(name: 'Negotiation')
OpportunityStatus.create(name: 'Ongoing')
OpportunityStatus.create(name: 'Won')
OpportunityStatus.create(name: 'Lost')
OpportunityStatus.create(name: 'New')

Opportunity.create(title: 'Secretarial Ministry of Defence Tanzania', description:'Opportunity Description. Got a call from xyz, inquired about program xyz, will be following up shortly with xyz', opportunity_status:OpportunityStatus.where(name: "New").take, user:User.find(1))

Organisation.create!(name: 'Kenya Roads Authority', address: 'Address of KRA here', postal_address: 'P.O Box 1112, Nairobi', country:Country.where(name: 'Kenya').take, telephones: "+25487988729, +25499823008", email_address: 'info@kra.go.ke', website:'www.kra.go.ke')

Participant.create!(name: 'Ken', other_names: 'Kens Kenny', sex: 'Male', passport_no: 'B009786', job_title: 'Secretary for xyz', organisation: Organisation.find(1))
Participant.create!(name: 'Ogopa', other_names: 'Florence', sex: 'Female', passport_no: 'B109786', job_title: 'Secretary also number 2 for xyz', organisation: Organisation.find(1))

Training.create!(title: "Skills Enhancement Programme For Executive Secretaries and Administrative / Personal Assistants", participants: [Participant.first, Participant.find(2)], program: Program.first, start_date: today + 2.week, end_date: today + 5.week, fees: 2500, fees_paid: 0, fees_balance: 2500, program_venue: ProgramVenue.first)

#t.participants = [Participant.first, Participant.find(2)]

Training.create!(participants: [Participant.first, Participant.find(2), Participant.first, Participant.first], program: Program.find(2), start_date: today + 4.week, end_date: today + 7.week, fees: 2200, fees_paid: 1500, fees_balance: 700, program_venue: ProgramVenue.first)

#t2.participants = [Participant.first, Participant.find(2), Participant.first, Participant.first]

n = Notification.create!(notification:'System setup complete!')
UserNotification.create(notification: n, user: User.first)

ai = AccountsInvoice.create!(training: Training.find(1), invoice_date: today, invoice_terms: 'Payment must be send in dollars etc etc', currency: 'USD')
ai.accounts_invoice_items = [AccountsInvoiceItem.create!(description: 'Training fees', units: 3, unit_cost: 1500), AccountsInvoiceItem.create!(description: 'Other fees', units: 3, unit_cost: 150), AccountsInvoiceItem.create!(description: 'Taxes 18%', units: 1, unit_cost: 674)]

4.times do
  Expense.create(item: Faker::Commerce.product_name,
               description: Faker::Hipster.paragraph,
               expense_date: today, qty: Faker::Number.between(1, 20), unit_price: Faker::Number.between(600, 1500),
                 tax: Faker::Number.between(100, 600), invoice_ref: Faker::Address.zip)
end

3.times do
  Asset.create(name: Faker::Commerce.product_name,
               description: Faker::Hipster.paragraph,
               asset_category: Asset::ASSET_CATEGORIES[Faker::Number.between(0, 2)], current_value: Faker::Number.between(1200, 3000), country: Country.find(1))
end

Settings.add_source!("#{Rails.root}/config/settings/supply_items_list.yml")
Settings.reload!
supplies = Settings.supplies_items_list

supplies.each do |cat, items|
  sc = SupplyItemCategory.create!(name: cat)
  items.each do |item|
    SupplyItem.create!(supply_item_category: sc, name: item)
  end
end

3.times do
  sp = Supplier.create!(name: Faker::Company.name, shop_name: Faker::Company.name,
                   contact_numbers: Faker::PhoneNumber.phone_number, address: Faker::Address.street_address,
                   town: Faker::Address.city, country: Country.find(1))

  5.times do
    Supply.create!(supplier:sp, supply_item: SupplyItem.find(Faker::Number.between(1, 20)))
  end
end

3.times do
  rfq = Rfq.create!(rfq_id:Faker::Address.zip_code, action: 'Find partners, Research, Write and submit proposal',
              rfq_date:today, due_date: today + 6.weeks, issuer: Faker::Company.name, description:Faker::Hipster.paragraph)
end

5.times do
  ts = Task.create!(title: Faker::Lorem.sentence, task_type: Task::TASK_TYPE[Faker::Number.between(0,2)],
                    start_date:today, end_date: today + 1.week, status: Task::TASK_STATUS[Faker::Number.between(0, 4)],
                    description: Faker::Hipster.paragraph)

  Assignment.create!(task:ts, user: User.find(Faker::Number.between(0, 8)))
end