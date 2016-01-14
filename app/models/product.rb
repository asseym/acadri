class Product < ActiveRecord::Base
  actable
  
  belongs_to :category
end
