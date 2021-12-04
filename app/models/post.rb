class Post < ApplicationRecord
  def self.search(keyword)
    where(["question like? OR answer like?", "%#{keyword}%", "%#{keyword}%"])
  end
end
