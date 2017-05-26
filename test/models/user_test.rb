require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_many(:votes).through(:cases)
  should have_many(:cases)

  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)
  should validate_presence_of(:role)
  should validate_presence_of(:email)

  #email
  should validate_uniqueness_of(:email)
  should allow_value("jason95014@gmail.com").for(:email)
  should allow_value("jasonc1@andrew.cmu.edu").for(:email)
  should_not allow_value("j@gmail.com").for(:email)
  should_not allow_value("").for(:email)
  should_not allow_value(32).for(:email)

  #phone
  should allow_value("4122683259").for(:phone)
  should allow_value("412-268-3259").for(:phone)
  should allow_value("412.268.3259").for(:phone)
  should allow_value("(412) 268-3259").for(:phone)
  should allow_value(nil).for(:phone)
  should_not allow_value("2683259").for(:phone)
  should_not allow_value("14122683259").for(:phone)
  should_not allow_value("4122683259x224").for(:phone)
  should_not allow_value("800-EAT-FOOD").for(:phone)
  should_not allow_value("412/268/3259").for(:phone)
  should_not allow_value("412-2683-259").for(:phone)

  #role
  should allow_value("admin").for(:role)
  should allow_value("deacon").for(:role)
  should_not allow_value("bad").for(:role)
  should_not allow_value("hacker").for(:role)
  should_not allow_value(10).for(:role)
  should_not allow_value("vp").for(:role)
  should_not allow_value(nil).for(:role)

  context "Creating a context for users" do
    setup do
      create_users
      create_cases
      create_votes
      # create_documents
      # create_case_documents
    end

    teardown do
      # remove_case_documents
      # remove_documents
      remove_votes
      remove_cases
      remove_users
    end

    #running the tests:
    should "show that there is one inactive user" do
      assert_equal 1, User.inactive.size
      assert_equal ["Troy"], User.inactive.map{|e| e.last_name}.sort
    end
    should "show that there are 4 active users" do
      assert_equal 4, User.active.size
      assert_equal ["Chen", "Heimann", "Seed", "Wu"], User.active.map{|e| e.last_name}.sort
    end

    should "show that there is 1 care deacon" do
      assert_equal 1, User.care_deacons.size
      assert_equal ["Wu"], User.care_deacons.map{|e| e.last_name}.sort
    end

    should "show that there are 3 financial deacons" do
      assert_equal 3, User.financial_deacons.size
      assert_equal ["Chen", "Heimann", "Troy"], User.financial_deacons.map{|e| e.last_name}.sort
    end

    should "show that there is 1 care connector" do
      assert_equal 1, User.care_connectors.size
      assert_equal ["Seed"], User.care_connectors.map{|e| e.last_name}.sort
    end

    should "show that the alphabetical scope works" do
      assert_equal 5, User.alphabetical.size
      assert_equal ["Chen", "Heimann", "Seed", "Troy", "Wu"], User.alphabetical.map{|e| e.last_name}.sort
    end

    should "show that the name method works" do
      assert_equal "Chen, Jason", @jason.name
    end

    should "show that the proper_name method works" do
      assert_equal "Jason Chen", @jason.proper_name
    end

    should "shows that Ben's phone is stripped of non-digits" do
      assert_equal "4089315510", @jason.phone
    end


    should "have working role? method to be used in ability.rb" do
      assert_equal true, @jason.role?(:admin)
      assert_equal true, @jon.role?(:deacon)
      assert_equal false, @jason.is_care_deacon?
      assert_equal true, @jon.is_care_deacon?
    end
  end
end
