module Mapping
  class Children < Base
    self.fields = [
      Field.new(name: :first_name, permission: 'child-data'),
      Field.new(name: :last_name,  permission: 'child-data'),
      Field.new(name: :age,        permission: 'child-data'),
      Field.new(name: :dob,        permission: 'child-personal-data')
    ]
  end
end