class CreateObjs < ActiveRecord::Migration[6.0]
  def change
    create_table :objs do |t|
      t.references :vocab, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
