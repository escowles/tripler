class Obj < ApplicationRecord
  belongs_to :vocab

  def to_s
    "#{vocab.prefix}:#{name}"
  end
end
