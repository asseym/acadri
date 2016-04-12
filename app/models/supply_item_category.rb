class SupplyItemCategory < ActiveRecord::Base
  has_many :supply_items
  validates_presence_of :name
  accepts_nested_attributes_for :supply_items
end
