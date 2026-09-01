class Delivery < ApplicationRecord
  include AASM

  aasm column: :status do
    state :pending, initial: true
    state :picked_up
    state :in_transit
    state :delivered
    state :failed

    event :pick_up do
      transitions from: :pending, to: :picked_up
    end

    event :start_transit do
      transitions from: :picked_up, to: :in_transit
    end

    event :deliver do
      transitions from: :in_transit, to: :delivered
    end

    event :fail do
      transitions from: %i[pending picked_up in_transit], to: :failed
    end
  end
end
