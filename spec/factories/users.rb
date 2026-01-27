# spec/factories/users.rb

# FactoryBot.define do
#   factory :user do
#     email { 'test@example.com' } # Use a block for dynamic attributes
#     password { 'password123' }

#     # You can add a trait for different variations, e.g., an admin user
#     trait :admin do
#       role { :admin }
#     end

#     factory :admin_user, traits: [:admin]
#   end
# end




FactoryBot.define do 
  factory :user do 
    email {'gourav@gmail.com'}
    name  {'Gourav Rathore'}
    role  {'user'}
    password {'Gourav@12'}
  end
end