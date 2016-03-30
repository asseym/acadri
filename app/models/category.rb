class Category < ActiveRecord::Base
  validates_presence_of :name

  SEARCH_FIELDS = [:name]

  def self.like(query)
    # where(:title, query) -> This would return an exact match of the query
    joined = Category
    SEARCH_FIELDS.each_with_index { |field, index|
      if joined.where("#{field.to_s} LIKE ?","%#{query}%").count > 0 then
        return joined.where("#{field.to_s} LIKE ?", "%#{query}%")
        break
      elsif index == SEARCH_FIELDS.size - 1
        return where(1)
      end
    }
  end
end
