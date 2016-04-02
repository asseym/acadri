class Supply < ActiveRecord::Base
  belongs_to :supplier
  belongs_to :supply_item
end
