module Contexts
  module UserContexts
    def create_users
      @jason = FactoryGirl.create(:user)
      @jon = FactoryGirl.create(:user, first_name: "Jon", last_name: "Wu", email: "jonWu@gmail.com", password_digest: "meh", phone: "4121112222", role: "head_deacon")
      @larry = FactoryGirl.create(:user, first_name: "Larry", last_name: "Heimann", email: "LarryH@gmail.com", password_digest: "meh", phone: "4123334444", role: "financial_deacon")
      @paula = FactoryGirl.create(:user, first_name: "Paula", last_name: "Troy", email: "PaulaT@gmail.com", password_digest: "meh", phone: "4125556666", role: "care_deacon", active: false)
      @staff = FactoryGirl.create(:user, first_name: "Apple", last_name: "Seed", email: "connect@gmail.com", password_digest: "meh", phone: "4121112222", role: "staff")
      @care = FactoryGirl.create(:user, first_name: "Tazer", last_name: "Card", email: "bandana@gmail.com", password_digest: "meh", phone: "4125556666", role: "care_deacon")

    end

    def remove_users
      @paula.destroy
      @larry.destroy
      @jon.destroy
      @jason.destroy
      @staff.destroy
      @care.destroy
    end

  end
end
