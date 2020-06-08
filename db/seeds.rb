
# アルファベット順で索引をつけるためのもの
( ("0".."9").to_a.push( ('A'..'Z').to_a ).flatten ).each do |index|
  Tag.create(name:index)
end
