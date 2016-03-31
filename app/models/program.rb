class Program < ActiveRecord::Base
  
  #A program is a product (Multi-table inherentance here MTI)
  # acts_as :product
  belongs_to :category
  has_many :programdates, autosave: true, :class_name => 'ProgramDate'
  has_many :programvenues, autosave: true, :class_name => 'ProgramVenue'
  
  validates_presence_of :name, :category
  validates :is_service, :inclusion => {:in => [true, false]}
  
  accepts_nested_attributes_for :programdates, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :programvenues, reject_if: :all_blank, allow_destroy: true
  
  def self.human_attribute_name(*args)
    if args[0].to_s == "name"
      return "Program Title"
    end
    super
  end

  def to_s
    name
  end

  def dates
    dts = []
    for pg in programdates.all
      dts.push(pg.to_s)
    end
    dts
  end

  def venues
    vns = []
    for pv in programvenues.all
      vns.push(pv.to_s)
    end
    vns
  end
  
end
