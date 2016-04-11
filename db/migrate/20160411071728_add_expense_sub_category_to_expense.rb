class AddExpenseSubCategoryToExpense < ActiveRecord::Migration
  def change
    add_reference :expenses, :expense_sub_category, index: true, foreign_key: true
  end
end
