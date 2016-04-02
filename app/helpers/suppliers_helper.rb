module SuppliersHelper
  def list_of_supplies(supplier)
    lst = '<ul>'
    unless supplier.supply_items.empty?
      supplier.supply_items.each do |si|
        lst += "<li>#{si.name}</li>"
      end
    end
    lst += '</ul>'
    lst.html_safe
  end

  def get_category_items(si_cat)
    @supply_items.where(supply_item_category: si_cat)
  end
end
