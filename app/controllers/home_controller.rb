# frozen_string_literal: true

class HomeController < InertiaController
  def index
    @deliveries = Delivery.all
  end
end
