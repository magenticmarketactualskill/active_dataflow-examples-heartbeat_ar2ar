class BeforeXform < ActiveRecord::Base
  self.table_name = 'before_xforms'
  
  serialize :values, Array
  
  has_one :after_xform, dependent: :destroy
  
  validates :values, presence: true
  validate :values_must_be_array
  validate :values_must_be_numeric
  
  def compute_sum
    return 0 if values.empty?
    values.sum
  end
  
  def create_after_xform
    sum_value = compute_sum
    after_xform = build_after_xform(sum: sum_value)
    after_xform.save
    after_xform
  rescue => e
    errors.add(:base, "Failed to create after_xform: #{e.message}")
    nil
  end
  
  private
  
  def values_must_be_array
    unless values.is_a?(Array)
      errors.add(:values, "must be an array")
    end
  end
  
  def values_must_be_numeric
    return unless values.is_a?(Array)
    return if values.empty?
    
    non_numeric = values.reject { |v| v.is_a?(Numeric) }
    if non_numeric.any?
      errors.add(:values, "all values must be numeric")
    end
  end
end
