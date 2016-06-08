class Project < ApplicationRecord
  belongs_to :user
  has_many :documents, dependent: :destroy
end
