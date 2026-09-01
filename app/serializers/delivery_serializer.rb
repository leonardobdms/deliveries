class DeliverySerializer < ApplicationSerializer
  typelize_from Delivery

  attributes :id, :order_id, :status, :address
end
