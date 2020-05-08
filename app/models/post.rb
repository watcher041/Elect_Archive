class Post < ApplicationRecord

  belongs_to :user

  mount_uploader :image, ImageUploader

  validates :title,  presence: true
  validates :author, presence: true
  validates :image,  presence: true
  validates :text,   presence: true

  def self.search(search)

    # キーワードがなければ全てのデータを渡す
    return Tweet.all unless search

    # 空白でキーワードが渡されたことを考慮して検索を行う
    keywords = search.split(/[[:blank:]]+/)
    result = []
    keywords.each do |keyword|

      # 先頭に空白がある場合に消去する
      next if keyword == "" 
      result += Post.where(' (title LIKE(?)) OR (author LIKE(?)) ', "%#{keyword}%", "%#{keyword}%")
    end

    # 検索結果がかぶるため、重複する要素は消去
    result.uniq
  end

end
