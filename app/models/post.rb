class Post < ApplicationRecord
  validates :question, presence: true
  validates :question_type, presence: true
  validates :answer, presence: true

  def self.search(keyword)
    where(["question like? OR answer like?", "%#{keyword}%", "%#{keyword}%"])
  end
end
