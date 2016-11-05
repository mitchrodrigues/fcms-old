require 'rails_helper'


describe Staff do
  before :each do 
    @staff = Staff.create({
      email: 'test@example.com', 
      password: 'testPass'
    })
  end

  context "#login" do
    it "should update the login information when login is called" do      
      # user = Staff.login('test', 'testPass', '127.0.0.1')
      # history = Staff.login_histories.first
      # expect(history.ip_address).to eql('127.0.0.1')
    end
    
    it "should return nil if the password does not match" do
      expect(Staff.login('test', 'badPass')).to be_nil
    end

    it "should return nil if the email does not match" do
      expect(Staff.login('testUser', 'testPass')).to be_nil
    end    
  end

  context "#passwords" do
    it "should not save a user if the password is less then 6" do
      staff = Staff.create(email: 'test@example.com', password: 'test')
      expect(staff.new_record?).to eql(true)
      expect(staff.valid?).to eql(false)
    end

    it "should encrypt passwords only after save" do
      expect(@staff.password).not_to eql('testPass')
    end

    it "should only encrypt if hte password has changed" do
      pass = @staff.password.to_s
      @staff.save

      expect(@staff.password).to eql(pass)
    end
  end


  context "#name_search" do
    it "should build a query for both first last names from 1 name" do
      result = Staff.name_search_clause("Georgy")
      expect(result).to eql(["first_name LIKE ? OR last_name LIKE ?", 'Georgy%', 'Georgy%'])
    end

    it "should build a query to search both names seperately" do 
     result = Staff.name_search_clause("Georgy Forman")
     expect(result).to eql([
       "(first_name = ? AND last_name = ?) OR (last_name = ? AND first_name = ?)", 
       'Georgy', 'Forman', 'Georgy', 'Forman'
     ])
    end 
  end
end