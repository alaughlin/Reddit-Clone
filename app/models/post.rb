class Post < ActiveRecord::Base
  validates :title, :user_id, presence: true

  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :user_id
  )

  has_many :post_subs

  has_many :subs, through: :post_subs

end
