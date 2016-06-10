class Project < ApplicationRecord
  include Timestamp
  belongs_to :user
  has_many :documents, dependent: :destroy

  def updated_last_document_at_i
    if self.documents.length == 0
      -1
    else
      self.documents.map{|d| d.updated_at}.max.to_time.to_i
    end
  end
end
