
class Comment < ApplicationRecord

  belongs_to :user, optional: true
  
  validates :name,:text, presence: true

end
