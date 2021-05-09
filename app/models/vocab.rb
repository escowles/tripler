class Vocab < ApplicationRecord
  has_many :predicates, dependent: :destroy
end
