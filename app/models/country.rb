class Country < ActiveRecord::Base
  def self.human_attribute_name(*args)
    if args[0].to_s == "c_code"
      return "Country Code"
    end
    super
  end
end
