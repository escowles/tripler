class Vocab < ApplicationRecord
  has_many :predicates, dependent: :destroy
  has_many :objs, dependent: :destroy
end
