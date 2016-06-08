class Document < ApplicationRecord
  belongs_to :project
  has_one :document_detail, dependent: :destroy
  
  before_create :build_default_detail
  
  private
  def build_default_detail
    if this.document_detail.nil?
      DocumentDetail.create(:document=>this)
    end
    true
  end
  
end
