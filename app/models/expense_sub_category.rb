class ExpenseSubCategory < ActiveRecord::Base
  belongs_to :expense_category

  def to_s
    self.name
  end
end
