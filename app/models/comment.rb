class Comment < ActiveRecord::Base
  validates :user_id, :post_id, :content, presence: true

  belongs_to :commentable, polymorphic: true

  has_many(
    :child_comments,
    class_name: "Comment",
    foreign_key: :parent_comment_id,
  )

  belongs_to :post

  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :user_id
  )

end
