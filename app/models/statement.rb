class Statement < ApplicationRecord
  belongs_to :subject
  belongs_to :predicate
  validates_associated :subject, :predicate
  validates :literal, presence: true
end
