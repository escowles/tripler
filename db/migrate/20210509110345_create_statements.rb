class CreateStatements < ActiveRecord::Migration[6.0]
  def change
    create_table :statements do |t|
      t.references :subject, null: false, foreign_key: true
      t.references :predicate, null: false, foreign_key: true
      t.string :literal

      t.timestamps
    end
  end
end
