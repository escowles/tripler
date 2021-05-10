class Vocab < ApplicationRecord
  has_many :predicates, dependent: :destroy
  has_many :objs, dependent: :destroy

  validates :prefix, :uri, presence: true
  validates :uri, format: { with: URI.regexp }, if: :present?
end
