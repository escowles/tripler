class CreateVocabs < ActiveRecord::Migration[6.0]
  def change
    create_table :vocabs do |t|
      t.string :prefix
      t.string :uri

      t.timestamps
    end
  end
end
