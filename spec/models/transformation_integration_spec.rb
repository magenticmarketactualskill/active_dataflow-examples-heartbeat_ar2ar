require 'rails_helper'

RSpec.describe 'Transformation Integration', type: :model do
  describe 'creating AfterXform from BeforeXform' do
    it 'creates after_xform with computed sum' do
      before_xform = BeforeXform.create!(values: [1, 2, 3, 4, 5])
      after_xform = before_xform.create_after_xform
      
      expect(after_xform).to be_persisted
      expect(after_xform.sum).to eq(15)
      expect(after_xform.before_xform).to eq(before_xform)
    end
    
    it 'handles empty arrays' do
      before_xform = BeforeXform.create!(values: [])
      after_xform = before_xform.create_after_xform
      
      expect(after_xform).to be_persisted
      expect(after_xform.sum).to eq(0)
    end
    
    it 'handles negative numbers' do
      before_xform = BeforeXform.create!(values: [-10, -5, 5, 10])
      after_xform = before_xform.create_after_xform
      
      expect(after_xform).to be_persisted
      expect(after_xform.sum).to eq(0)
    end
    
    it 'handles decimal numbers' do
      before_xform = BeforeXform.create!(values: [1.5, 2.5, 3.0])
      after_xform = before_xform.create_after_xform
      
      expect(after_xform).to be_persisted
      expect(after_xform.sum).to eq(7.0)
    end
    
    it 'handles large numbers' do
      before_xform = BeforeXform.create!(values: [1000000, 2000000, 3000000])
      after_xform = before_xform.create_after_xform
      
      expect(after_xform).to be_persisted
      expect(after_xform.sum).to eq(6000000)
    end
  end
  
  describe 'referential integrity' do
    it 'maintains relationship between models' do
      before_xform = BeforeXform.create!(values: [1, 2, 3])
      after_xform = before_xform.create_after_xform
      
      expect(before_xform.after_xform).to eq(after_xform)
      expect(after_xform.before_xform).to eq(before_xform)
    end
    
    it 'prevents orphaned after_xform records' do
      before_xform = BeforeXform.create!(values: [1, 2, 3])
      after_xform = before_xform.create_after_xform
      
      expect(after_xform.before_xform_id).to eq(before_xform.id)
      expect(after_xform.before_xform).to be_present
    end
  end
  
  describe 'cascade deletion' do
    it 'deletes after_xform when before_xform is deleted' do
      before_xform = BeforeXform.create!(values: [1, 2, 3])
      after_xform = before_xform.create_after_xform
      after_xform_id = after_xform.id
      
      before_xform.destroy
      
      expect(AfterXform.find_by(id: after_xform_id)).to be_nil
    end
    
    it 'maintains database integrity on deletion' do
      before_xform = BeforeXform.create!(values: [1, 2, 3])
      before_xform.create_after_xform
      
      expect { before_xform.destroy }.to change { AfterXform.count }.by(-1)
      expect { BeforeXform.count }.not_to raise_error
    end
  end
  
  describe 'edge cases' do
    it 'handles very large arrays' do
      large_array = Array.new(1000) { rand(1..100) }
      before_xform = BeforeXform.create!(values: large_array)
      after_xform = before_xform.create_after_xform
      
      expect(after_xform).to be_persisted
      expect(after_xform.sum).to eq(large_array.sum)
    end
    
    it 'handles single element arrays' do
      before_xform = BeforeXform.create!(values: [42])
      after_xform = before_xform.create_after_xform
      
      expect(after_xform).to be_persisted
      expect(after_xform.sum).to eq(42)
    end
    
    it 'handles arrays with zeros' do
      before_xform = BeforeXform.create!(values: [0, 0, 0])
      after_xform = before_xform.create_after_xform
      
      expect(after_xform).to be_persisted
      expect(after_xform.sum).to eq(0)
    end
  end
end
