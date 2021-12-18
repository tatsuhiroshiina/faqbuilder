class Post < ApplicationRecord
  validates :question, presence: true
  validates :question_type, presence: true
  validates :answer, presence: true

  def self.search(keyword)
    where(["cast(id as text) like? OR question_type like? OR title like? OR question like? OR answer like?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      # IDが見つかれば、レコードを呼び出し、見つかれなければ、新しく作成
      task = find_by(id: row["id"]) || new
      # CSVからデータを取得し、設定する
      task.attributes = row.to_hash.slice(*updatable_attributes)
      task.save
    end
  end

# 更新を許可するカラムを定義
  def self.updatable_attributes
    ["title", "question_type", "question", "answer"]
  end
end
