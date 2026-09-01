# frozen_string_literal: true

class DeliveriesController < InertiaController
  def update
    delivery = Delivery.find(params[:id])
    event = params[:event].to_s.to_sym

    unless delivery.aasm.may_fire_event?(event)
      redirect_back_or_to root_path, alert: "Invalid status transition"
      return
    end

    delivery.aasm.fire!(event)
    redirect_to root_path
  end
end
