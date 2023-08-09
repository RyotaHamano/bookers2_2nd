class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_one_attached :user_image
  
  has_many :books, dependent: :destroy
  
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  has_many :follow, class_name: 'Relation', foreign_key: "follow_id", dependent: :destroy
  has_many :followed, class_name: 'Relation', foreign_key: "followed_id", dependent: :destroy
  has_many :follow_user, through: :follow, source: :followed
  has_many :followed_user, through: :followed, source: :follow
  
  def get_user_image(width, height)
    unless user_image.attached?
      file_path = Rails.root.join('app/assets/images/sample.jpg')
      user_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    user_image.variant(resize_to_limit: [width, height]).processed
  end
  
  def follow?(user)
    follow_user.include?(user)
  end
  
  def self.looks(search, word)
    if search == 'perfect_match'
      @user = User.where("name LIKE?", "#{word}")
    elsif search == 'forward_match'
      @user = User.where("name LIKE?", "#{word}%")
    elsif search == 'backward_match'
      @user = User.where("name LIKE?", "%#{word}")
    elsif search == 'partial_match'
      @user = User.where("name LIKE?", "%#{word}%")
    else
      @user = User.all
    end
  end
  
end
