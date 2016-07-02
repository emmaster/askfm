class Question < ActiveRecord::Base

  belongs_to :user
  validates :user, presence: true
  validates :text, presence: true
  validates :text, length: {maximum: 255}


end
