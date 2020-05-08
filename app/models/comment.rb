class Comment < ApplicationRecord

  belongs_to :answer, optional: true

  validates :name,   presence: true
  validates :text,   presence: true

end
