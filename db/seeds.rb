# Top level Organization
puts "Starting Seed"

organization = Organization.create(name: "Test Organization", active: true)

# Create a default Office (Default Zone)
office       = organization.offices.create(name: "Head Quaters")
office.address_add(primary: true, street1: "456 N Main St", city: "Placervil", postal_code: 94560, state: "ca")

# Create a Facility
facility     = office.facilities.create(name: "Pro Care", organization_id: office.organization_id, bed_count: 2)

facility.address_add(primary: true, street1: "555 Facility Dr", city: "Cameron Park", postal_code: 95682, state: "ca")

# Staff / SocialWorker
staff = organization.staff.create({
          first_name: "Admin",
          last_name:  "Account",
          password:   "staff1234",
          email:      "admin@example.com"
        })


staff.address_add(primary: true, street1: "5584 Washington Dr", city: "Cameron Park", postal_code: 95682, state: "ca")

office.staff << staff

# Care Providers    
facility.care_providers << organization.providers.create([{
                            first_name: "George",
                            last_name:  "Castanza",
                            email: "something@example.com"
                          },{
                            first_name: "Emily",
                            last_name:  "Castanza",
                            email: "emily@example.com"
                          }])


# First create the child, this is currently unassigned or placed
children = organization.children.create([{
            first_name: "John",
            middle_name: "Carly",
            last_name:  "Doe",
            dob:     10.years.ago,
            social: "00000000"
           },{
            first_name: "Ethan",
            middle_name: "Rabit",
            last_name: "Hawken",
            dob: 7.years.ago,
            social: "0000000111"
           }])

# Lets create a family member for the child
family_members = organization.family_members.create([{
                  first_name: "Carly",
                  last_name:  "Doe",
                  dob:     60.years.ago,
                  social: "00000002"
                }, {
                  first_name: "Greg",
                  last_name: "Pinole",
                  dob: 57.years.ago,
                  social: "00000003"
                }])

family_members.each do |family_member|
  family_member.address_add(primary: true, street1: "666 1st ST", city: "Cameron Park", postal_code: 95682, state: "ca")
end


# Child assignments
# Place the child to a facility starting today
facility.children << children

# Assign a case worker
children.each do |child|
  child.staff  << staff
  child.family << family_members.first
end

# One of the family is only related to 1 of the children
children.last.family << family_members.last

# Tag the family member to this child as well
# Permissions
permissions = Permission.create([
  {
    name: 'child-person-data',
    description: 'Child Personal Data'
  },
  {
    name: 'child-data',
    description: 'View Basic Child Data'
  }
])

group = organization.groups.create({ name: 'Administrator' })
group.add_person(staff)

permissions.each do |permission|
  group.add_permission(permission: permission, level: 'write')
end


puts "Ending Seed"