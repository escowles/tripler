class Predicate < ApplicationRecord
  belongs_to :vocab
  validates :name, presence: true
  validates_associated :vocab

  def to_s
    "#{vocab.prefix}:#{name}"
  end
end
