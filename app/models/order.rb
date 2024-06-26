class Order < ApplicationRecord
  include AASM
  belongs_to :user
  after_create :assign_serial_number

  aasm column: :state do
    state :pending, initial: true
    state :submitted, :paid, :failed, :revoked

    event :submit do
      transitions from: :pending, to: :submitted
    end

    event :pay do
      transitions from: :submitted, to: :paid, success: :revise_balance
    end

    event :fail do
      transitions from: [:pending, :submitted], to: :failed
    end

    event :revoke do
      transitions from: :paid, to: :revoked, guard: :balance_enough?, success: :deduct_balance
    end

    def revise_balance
      user.update(balance: user.balance + amount)
    end

    def deduct_balance
      user.update(balance: user.balance - amount)
    end

    def balance_enough?
      user.balance >= amount
    end

  end

  private

  def assign_serial_number
    self.update(serial_number: "gem-#{id.to_s.rjust(9, '0')}")
  end

end