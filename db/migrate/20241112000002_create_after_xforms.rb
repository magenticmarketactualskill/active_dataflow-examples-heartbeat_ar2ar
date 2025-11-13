class CreateAfterXforms < ActiveRecord::Migration[7.0]
  def change
    create_table :after_xforms do |t|
      t.decimal :sum, precision: 15, scale: 2
      t.references :before_xform, null: false, foreign_key: true

      t.timestamps
    end
    
    add_index :after_xforms, :before_xform_id, unique: true
  end
end
