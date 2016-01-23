class Country < ActiveRecord::Base

  validates_presence_of :name
  validates_numericality_of :telephone_code

  def self.human_attribute_name(*args)
    if args[0].to_s == "c_code"
      return "Country Code"
    end
    super
  end

  def to_s
    name
  end
end
