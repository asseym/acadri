class ProductVenue < ActiveRecord::Base
  belongs_to :country
  belongs_to :program
end
