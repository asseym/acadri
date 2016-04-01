module ExpensesHelper
  def expense_sub_total(exp)
    if exp
      exp.qty * exp.unit_price
    end
  end
end
