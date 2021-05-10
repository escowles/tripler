class Subject < ApplicationRecord
  has_many :statements, dependent: :destroy

  validates :uri, presence: true
  validates :uri, format: { with: URI.regexp }, if: :present?

  def to_s
    uri
  end
end
