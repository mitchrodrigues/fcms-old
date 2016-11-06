class Organization < ActiveRecord::Base
  include Assignable

  has_many :offices

  # TODO for better metrics we need to more loosely couple
  # some of these as providers can be in multiple organizations.
  has_many :staff,     class_name: 'Staff'
  has_many :children,  class_name: 'Child'
  has_many :providers, class_name: 'CareProvider'
  has_many :family_members, class_name: "Family"
  
  # Generic for relation building
  has_many :people
  has_many :groups

end
