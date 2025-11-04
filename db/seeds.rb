puts "seed data for testing"
=begin
  
rescue 
end

buyer = BuyerUser.create!(
  name: "Adnan",
  email: "adnan@gmail.com",
  password: "123456",
  billing_day: 30.days.ago,
)

plan = Plan.create!(name: "basic", monthly_fee: 100)
feature1 = Feature.create!(name: "Sms", code: "S100", unit_price: 2, max_unit_limit: 100)
=end
admin = AdminUser.create!(
  name: "Admin",
  email: "admin@example.com",
  password: "admin123",
)
=begin
buyer.subscribe_to(plan)

Usage.create!(
  feature: feature1,
  subscription: buyer.active_subscription,
  units_used: 200,
  usage_date: 30.days.ago,
)

buyer1 = BuyerUser.create!(
  name: "Ali",
  email: "ali@gmail.com",
  password: "123456",
  billing_day: 31,
)
=end