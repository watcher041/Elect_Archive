class Post < ApplicationRecord

  # タグを重複なしに保存する
  before_save :find_or_create_tag
  after_destroy :not_association_tags_delete

  # has_manyを使用しないとdependentが適用されない
  belongs_to :user
  has_and_belongs_to_many :tags

  accepts_nested_attributes_for :tags, reject_if: :all_blank, allow_destroy: true
  mount_uploader :image, ImageUploader

  with_options presence: true do
    validates :title
    validates :author
    validates :image
    validates :text
  end

  # 検索された文字に合う書籍を取得
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

  private

  def find_or_create_tag
    self.tags = self.tags.map do |tag|
      Tag.find_or_create_by(name: tag.name)
    end
  end

  # 中間テーブ削除後に関連付けがなくなったタグを削除
  def not_association_tags_delete
    Tag.all.each do |tag|
      Tag.delete(tag.id) if tag.posts.empty?
    end
  end

end
