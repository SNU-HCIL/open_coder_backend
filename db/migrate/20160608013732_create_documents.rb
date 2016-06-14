class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.string :name
      t.integer :position
      t.references :project, foreign_key: true
      t.string :description
      t.integer :num_quotes
      t.integer :num_memos
      t.integer :num_codes
      t.integer :num_uncoded
      t.timestamps
    end
  end
end
