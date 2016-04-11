class Expense < ActiveRecord::Base
  belongs_to :expense_sub_category
  validates_presence_of :item, :expense_date, :qty, :unit_price
  validates_numericality_of :qty, :unit_price

  def to_s
    self.item
  end
end
