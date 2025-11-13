require 'rails_helper'

RSpec.describe AfterXform, type: :model do
  describe 'validations' do
    let(:before_xform) { BeforeXform.create!(values: [1, 2, 3]) }
    
    it 'validates presence of sum' do
      after_xform = AfterXform.new(before_xform: before_xform, sum: nil)
      expect(after_xform).not_to be_valid
      expect(after_xform.errors[:sum]).to include("can't be blank")
    end
    
    it 'validates numericality of sum' do
      after_xform = AfterXform.new(before_xform: before_xform, sum: 10)
      expect(after_xform).to be_valid
    end
    
    it 'validates presence of before_xform_id' do
      after_xform = AfterXform.new(sum: 10, before_xform_id: nil)
      expect(after_xform).not_to be_valid
      expect(after_xform.errors[:before_xform_id]).to include("can't be blank")
    end
    
    it 'allows valid after_xform' do
      after_xform = AfterXform.new(before_xform: before_xform, sum: 6)
      expect(after_xform).to be_valid
    end
  end
  
  describe 'associations' do
    it 'belongs to before_xform' do
      association = AfterXform.reflect_on_association(:before_xform)
      expect(association.macro).to eq(:belongs_to)
    end
    
    it 'can access associated before_xform' do
      before_xform = BeforeXform.create!(values: [1, 2, 3])
      after_xform = AfterXform.create!(before_xform: before_xform, sum: 6)
      
      expect(after_xform.before_xform).to eq(before_xform)
    end
  end
  
  describe 'unique constraint' do
    it 'enforces unique before_xform_id' do
      before_xform = BeforeXform.create!(values: [1, 2, 3])
      AfterXform.create!(before_xform: before_xform, sum: 6)
      
      duplicate = AfterXform.new(before_xform: before_xform, sum: 10)
      expect { duplicate.save! }.to raise_error(ActiveRecord::RecordNotUnique)
    end
  end
end
