class Document < ApplicationRecord
  include Timestamp
  belongs_to :project
  has_one :document_detail, dependent: :destroy
  
  before_save :build_default_detail
  
  private
  def build_default_detail
    if self.document_detail.nil?
      DocumentDetail.create(:document=>self)
    end
    true
  end
  
end
