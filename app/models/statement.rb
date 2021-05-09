class Statement < ApplicationRecord
  belongs_to :subject
  belongs_to :predicate
end
