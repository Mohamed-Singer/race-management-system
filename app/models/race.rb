class Race < ApplicationRecord
  has_many :race_entries, dependent: :destroy
  accepts_nested_attributes_for :race_entries, allow_destroy: true


  validates :name, presence: true
end
