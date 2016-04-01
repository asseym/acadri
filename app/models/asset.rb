class Asset < ActiveRecord::Base
  belongs_to :country

  validates_presence_of :name, :asset_category, :current_value, :country
  validates_numericality_of :current_value

  ASSET_CATEGORIES = ['Current Asset', 'Non Current Asset', 'Debt']

  def to_s
    self.name
  end
end
