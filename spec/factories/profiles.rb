FactoryBot.define do
    factory :profile do
      name { "Admin" }
      permissions { ["manage_users", "view_reports"] }
    end
  end