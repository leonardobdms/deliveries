# frozen_string_literal: true

class OrdersConsumer < ApplicationConsumer
  def consume
    messages.each { |message| handle(JSON.parse(message.raw_payload)) }
  end

  private

  def handle(payload)
    case payload.fetch("event")
    when "order.created"
      # Delivery is created only on confirmation.
    when "order.confirmed"
      create_delivery(payload)
    when "order.cancelled"
      fail_delivery(payload)
    end
  end

  def create_delivery(payload)
    Delivery.find_or_create_by!(order_id: payload.fetch("id")) do |delivery|
      delivery.address = payload.fetch("address")
    end
  end

  def fail_delivery(payload)
    delivery = Delivery.find_by(order_id: payload.fetch("id"))
    return if delivery.blank?
    return unless delivery.may_fail?

    delivery.fail!
  end
end
