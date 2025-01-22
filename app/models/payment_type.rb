class PaymentType < ApplicationRecord
  has_many :orders
  validates :name, presence: true

  scope :name_for, ->(id) { where(id: id).pluck(:name).first }
end
