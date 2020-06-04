class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id', dependent: :destroy

  def friends
    friends_array = friendships.map do |friendship|
      friendship.friend if friendship.confirmed
    end + inverse_friendships.map do |friendship|
            friendship.user if friendship.confirmed
          end
    friends_array.compact
  end

  def pending_friends
    friendships.map do |friendship|
      friendship.friend unless friendship.confirmed
    end .compact
  end

  def friend_requests
    inverse_friendships.map do |friendship|
      friendship.user unless friendship.confirmed
    end .compact
  end

  def confirm_friend(user)
    friendship = inverse_friendships.find do |friend|
      friend.user == user
    end
    friendship.confirmed = true
    friendship.save
  end

  def decline_friend(user)
    inverse_friendships.where(user_id: user.id).first.destroy
  end

  def friend?(user)
    friends.include?(user)
  end

  def send_request(user)
    friendships.create(friend_id: user.id, confirmed: false) unless pending_friends.include?(user)
  end
end
