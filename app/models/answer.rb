class Answer < ApplicationRecord

  belongs_to :comment

  validates :name,   presence: true
  validates :text,   presence: true

end
