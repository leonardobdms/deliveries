require "faker"

Faker::Config.locale = "pt-BR"

SEED_COUNT = 25

puts "Seeding #{SEED_COUNT} deliveries..."

Delivery.destroy_all

statuses = Delivery.aasm.states.map(&:name)

SEED_COUNT.times do |index|
  Delivery.create!(
    order_id: index + 1,
    address: Faker::Address.full_address,
    status: statuses[index % statuses.length]
  )
end

puts "Created #{Delivery.count} deliveries."
