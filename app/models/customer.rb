class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :validatable

  has_many :post_cosmes, dependent: :destroy#post_cosmeとアソシエーション
  has_many :comments, dependent: :destroy#コメント機能とアソシエーション

  has_one_attached :profile_image

  validates :name, presence: true
  validates :email, presence: true

  def get_profile_image(width, height)#プロフィール画像
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def self.guest#ゲストログイン
    find_or_create_by!(email: 'guest@example.com', name: 'ゲスト') do |customer|
      customer.password = SecureRandom.urlsafe_base64
    end
  end
end