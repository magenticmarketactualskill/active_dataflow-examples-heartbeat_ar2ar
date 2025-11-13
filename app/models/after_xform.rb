class AfterXform < ActiveRecord::Base
  self.table_name = 'after_xforms'
  
  belongs_to :before_xform
  
  validates :sum, presence: true, numericality: true
  validates :before_xform_id, presence: true
end
