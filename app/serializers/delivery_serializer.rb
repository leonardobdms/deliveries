# frozen_string_literal: true

class DeliverySerializer < ApplicationSerializer
  typelize_from Delivery

  attributes :id, :order_id, :status, :address

  many :actions, source: proc { |_params| StatusActionSerializer.for(self) }, resource: StatusActionSerializer
end
