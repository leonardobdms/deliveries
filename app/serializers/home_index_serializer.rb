class HomeIndexSerializer < ApplicationSerializer
  has_many :deliveries, resource: DeliverySerializer
end
