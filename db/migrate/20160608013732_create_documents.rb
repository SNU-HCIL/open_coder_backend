class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.string :name
      t.integer :position
      t.references :project, foreign_key: true
      t.string :description
      t.timestamps
    end
  end
end
