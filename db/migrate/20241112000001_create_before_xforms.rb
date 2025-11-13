class CreateBeforeXforms < ActiveRecord::Migration[7.0]
  def change
    create_table :before_xforms do |t|
      t.text :values

      t.timestamps
    end
  end
end
