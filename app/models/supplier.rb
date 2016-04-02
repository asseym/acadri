class Supplier < ActiveRecord::Base
  belongs_to :country
  has_many :supplies
  has_many :supply_items, through: :supplies

  accepts_nested_attributes_for :supplies
  accepts_nested_attributes_for :supply_items

  validates_presence_of :name, :address, :town, :country

  def to_s
    name
  end
end
