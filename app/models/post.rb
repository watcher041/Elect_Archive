class Post < ApplicationRecord

  belongs_to :user
  has_many :post_tags ,dependent: :destroy
  has_many :tags, through: :post_tags
  accepts_nested_attributes_for :tags, allow_destroy: true

  mount_uploader :image, ImageUploader

  with_options presence: true do
    validates :title
    validates :author
    validates :image
    validates :text
  end

  validates_associated :tags

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

      # タグから入力した文字で検索を行う
      result += Post.joins(:tags).where( 'name LIKE(?)', "%#{keyword}%" )

    end

    # 検索結果がかぶるため、重複する要素は消去
    result.uniq
  end

end
