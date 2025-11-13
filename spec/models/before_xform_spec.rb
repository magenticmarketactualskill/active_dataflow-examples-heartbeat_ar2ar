require 'rails_helper'

RSpec.describe BeforeXform, type: :model do
  describe 'validations' do
    it 'validates presence of values' do
      before_xform = BeforeXform.new(values: nil)
      expect(before_xform).not_to be_valid
      expect(before_xform.errors[:values]).to include("can't be blank")
    end
    
    it 'validates that values is an array' do
      before_xform = BeforeXform.new(values: "not an array")
      expect(before_xform).not_to be_valid
      expect(before_xform.errors[:values]).to include("must be an array")
    end
    
    it 'validates that all values are numeric' do
      before_xform = BeforeXform.new(values: [1, "two", 3])
      expect(before_xform).not_to be_valid
      expect(before_xform.errors[:values]).to include("all values must be numeric")
    end
    
    it 'allows empty arrays' do
      before_xform = BeforeXform.new(values: [])
      expect(before_xform).to be_valid
    end
    
    it 'allows arrays with numeric values' do
      before_xform = BeforeXform.new(values: [1, 2, 3])
      expect(before_xform).to be_valid
    end
  end
  
  describe 'serialization' do
    it 'serializes and deserializes array values' do
      before_xform = BeforeXform.create!(values: [1, 2, 3, 4, 5])
      reloaded = BeforeXform.find(before_xform.id)
      expect(reloaded.values).to eq([1, 2, 3, 4, 5])
    end
    
    it 'maintains array order' do
      before_xform = BeforeXform.create!(values: [5, 3, 1, 4, 2])
      reloaded = BeforeXform.find(before_xform.id)
      expect(reloaded.values).to eq([5, 3, 1, 4, 2])
    end
  end
  
  describe '#compute_sum' do
    it 'returns 0 for empty array' do
      before_xform = BeforeXform.new(values: [])
      expect(before_xform.compute_sum).to eq(0)
    end
    
    it 'computes sum of positive integers' do
      before_xform = BeforeXform.new(values: [1, 2, 3, 4, 5])
      expect(before_xform.compute_sum).to eq(15)
    end
    
    it 'computes sum of negative integers' do
      before_xform = BeforeXform.new(values: [-5, -3, -2])
      expect(before_xform.compute_sum).to eq(-10)
    end
    
    it 'computes sum of mixed positive and negative' do
      before_xform = BeforeXform.new(values: [-5, 5, -3, 3])
      expect(before_xform.compute_sum).to eq(0)
    end
    
    it 'computes sum of decimal numbers' do
      before_xform = BeforeXform.new(values: [1.5, 2.5, 3.0])
      expect(before_xform.compute_sum).to eq(7.0)
    end
    
    it 'computes sum of large numbers' do
      before_xform = BeforeXform.new(values: [1000000, 2000000])
      expect(before_xform.compute_sum).to eq(3000000)
    end
  end
  
  describe 'associations' do
    it 'has one after_xform' do
      association = BeforeXform.reflect_on_association(:after_xform)
      expect(association.macro).to eq(:has_one)
    end
    
    it 'destroys associated after_xform when destroyed' do
      before_xform = BeforeXform.create!(values: [1, 2, 3])
      after_xform = before_xform.create_after_xform
      
      expect { before_xform.destroy }.to change { AfterXform.count }.by(-1)
    end
  end
end
