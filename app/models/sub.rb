class Sub < ActiveRecord::Base
  validates :title, :description, presence: true

  has_many :post_subs

  has_many :posts, through: :post_subs
  # has_many :moderators

  private

  def is_moderator?(user)
    moderators.exists?(id: user.id)
  end

end
