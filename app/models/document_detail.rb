class DocumentDetail < ApplicationRecord
  belongs_to :document

  before_save :update_parent_statistics_cache

  private
  def update_parent_statistics_cache
    logger.info self.document
    if !self.document.nil?
      if !self.memos_json.nil?
        self.document.update_columns(:num_memos=> JSON.parse(self.memos_json).length)
      end

      if !self.quotes_json.nil?
        quotes = JSON.parse(self.quotes_json)
        self.document.update_columns(
          :num_quotes => quotes.length,
          :num_codes => quotes.map{|q| q["codes"]}.flatten.map{|c|c["content"]}.uniq.length,
          :num_uncoded => quotes.select{|q| q["codes"].blank?}.length
          )

      end
    end
  end

end
