class Sub < ActiveRecord::Base
  validates :title, :description, presence: true

  has_many :posts, dependent: :destroy
  # has_many :moderators

  private

  def is_moderator?(user)
    moderators.exists?(id: user.id)
  end

end
