class Subject < ApplicationRecord
  has_many :statements, dependent: :destroy
end
