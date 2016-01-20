class Program < ActiveRecord::Base
  
  #A program is a product (Multi-table inherentance here MTI)
  # acts_as :product
  belongs_to :category
  has_many :programdates, autosave: true, :class_name => 'ProgramDate'
  has_many :programvenues, autosave: true, :class_name => 'ProgramVenue'
  
  validates_presence_of :name, :category_id, :description #, :programdates, :programvenues
  #validates_inclusion_of :field_name, :in => [true, false]
  
  accepts_nested_attributes_for :programdates
  accepts_nested_attributes_for :programvenues
  
  def self.human_attribute_name(*args)
    if args[0].to_s == "name"
      return "Program Title"
    end
    super
  end
  
end
