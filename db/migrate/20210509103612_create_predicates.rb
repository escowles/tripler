class CreatePredicates < ActiveRecord::Migration[6.0]
  def change
    create_table :predicates do |t|
      t.string :name
      t.references :vocab, null: false, foreign_key: true

      t.timestamps
    end
  end
end
