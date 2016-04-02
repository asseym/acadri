class SupplyItem < ActiveRecord::Base
  has_many :supplies
  has_many :suppliers, through: :supplies
  belongs_to :supply_item_category

  accepts_nested_attributes_for :supplies
  accepts_nested_attributes_for :suppliers

  validates_presence_of :name

  def to_s
    name
  end
end
