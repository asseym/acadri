module AccountsInvoincesHelper
  def invoice_number(invoice)
    return invoice.id.to_s.rjust(6, '0')
  end
  def invoice_organisation(invoice)
    if not invoice.training.participants.blank?
      return invoice.training.participants.first.organisation.name
    end
  end
  
  def invoice_training(invoice)
    return truncate(invoice.training.program.name)
  end
end
