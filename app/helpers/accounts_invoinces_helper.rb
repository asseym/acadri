module AccountsInvoincesHelper
  def invoice_number(invoice)
    return invoice.invoice_number.to_s.rjust(6, '0')
  end
  def invoice_organisation(invoice)
    if not invoice.training.participants.blank?
      return invoice.training.participants.first.organisation
    end
  end
  
  def invoice_training(invoice)
    return truncate(invoice.training.program.name)
  end

  def acadri_address
    address = '<p>'
    address += 'Africa Capacity Development and Research Institute<br />'
    address += '12345 Sunny Road<br />'
    address += 'P.O Box 12345</p>'
    address.html_safe
  end

  def org_details(invoice, detail='address')
    if detail == 'address'
      return organisation_address(invoice)
    elsif detail == 'website'
      return organisation_website(invoice)
    else
      return organisation_name(invoice)
    end
  end

  def organisation_address(invoice)
    begin
      org = invoice_organisation(invoice)
      address = org.name
      address += "#{org.address}<br />"
      address += "#{org.address}<br />"
      address.html_safe
    rescue NoMethodError
      return '--------'
    end
  end

  def organisation_website(invoice)
    begin
      return invoice_organisation(invoice).website
    rescue NoMethodError
      return '---------'
    end
  end

  def organisation_name(invoice)
    begin
      return invoice_organisation(invoice).name
    rescue Exception => e
      return '---------'
    end
  end


  def invoice_total(invoice)
    total = 0
    invoice.accounts_invoice_items.each do |item|
      if item.comp_action == 'add'
        total += item.units * item.unit_cost
      else
        total -= item.units * item.unit_cost
      end
    end
    total
  end

  def item_subtotal(item)
    sign = item.comp_action == 'add' ? '+' : '-'
    subtotal = item.units * item.unit_cost
    sign + "#{subtotal.to_s}"
  end
end
