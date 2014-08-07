class Post < ActiveRecord::Base
  validates :title, :user_id, presence: true

  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :user_id
  )

  has_many :post_subs

  has_many :subs, through: :post_subs

  has_many(
    :top_level_comments,
    -> { where(parent_comment_id: nil) },
    class_name: "Comment",
    foreign_key: :post_id
  )

  has_many(
    :comments,
    class_name: "Comment",
    foreign_key: :post_id
  )

  def comments_by_parent_id
    @all_comments = comments
    res = Hash.new { |hash, key| hash[key] = [] }
    @all_comments.each do |comment|
      res[comment.parent_comment_id] << comment
    end

    res
  end
end
