class ExpenseCategory < ActiveRecord::Base
  has_many :expense_sub_categories
  accepts_nested_attributes_for :expense_sub_categories
  def to_s
    self.name
  end
end
