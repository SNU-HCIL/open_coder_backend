class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.references :user, foreign_key: true
      t.string :description
      t.timestamps
    end
  end
end
