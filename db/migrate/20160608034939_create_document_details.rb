class CreateDocumentDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :document_details do |t|
      t.string :memos_json
      t.string :quotes_json
      t.references :document, foreign_key: true
      t.timestamps
    end
  end
end
