class Post < ApplicationRecord

  # タグを重複なしに保存する
  before_save :find_or_create_tag
  before_update :find_or_create_tag

  # has_manyを使用しないとdependentが適用されない
  belongs_to :user
  has_many :posts_tags
  has_many :tags, through: :posts_tags ,dependent: :destroy

  accepts_nested_attributes_for :tags, allow_destroy: true
  mount_uploader :image, ImageUploader

  with_options presence: true do
    validates :title
    validates :author
    validates :image
    validates :text
  end

  # 検索された文字に合う書籍を取得
  def self.search(search,tag_id)

    # キーワードがなければ一つのタグに属する、あるいは全ての書籍を返す
    if tag_id

      return Tag.find(tag_id).posts
    
    elsif search.blank?

      return Post.all

    else

      # 空白を開けて複数のキーワードが渡されたことを考慮して検索を行う
      keywords = search.split(/[[:blank:]]+/)
      result = []

      keywords.each do |keyword|

        # 先頭に空白がある場合に消去する
        next if keyword == "" 
        result += Post.where(' (title LIKE(?)) OR (author LIKE(?)) ', "%#{keyword}%", "%#{keyword}%")

        # タグから入力した文字で検索を行う
        tag = Tag.find_by("name LIKE(?)", "%#{keyword}%")
        result += tag.posts if tag

      end

      # 検索結果がかぶるため、重複する要素は消去
      result.uniq

    end

  end 

  # 編集、削除においてタグを削除した際の処理
  def update_or_delete_tag(post_params)

    # 情報を更新
    self.updated_at = Time.now

    post_params[:tags_attributes].each{ |key,value|

      # 削除されている場合は、以下の作業を行う
      next if value[:_destroy].blank?

      # 中間テーブルの削除
      tag =  self.tags.find(value[:id])
      PostsTag.find_by( post_id: self.id , tag_id: value[:id] ).delete

      # pramsの引数を削除する
      post_params[:tags_attributes].delete(key)
      
      # 関連がなくなったタグの削除
      if tag.posts.length == 0
        tag.delete
      end

    }

    return post_params

  end

  private

  def find_or_create_tag
    self.tags = self.tags.map do |tag|
      word = Zipang.to_slug tag[:name]
      parent = Tag.find_by( ancestry: nil, name: word[0].upcase )
      parent.children.find_or_create_by(name: tag.name)
    end
  end

end
