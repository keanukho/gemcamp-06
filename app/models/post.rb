class Post < ApplicationRecord
  default_scope { where(deleted_at: nil) }
  # validates :title, format: { with: /\A[a-zA-Z\s]{1,8}\z/, message: "only allows letters and spaces, maximum of 8 characters" }
  # validates :content, format: { with: /\A[a-zA-Z\s]{1,50}\z/, message: "only allows letters and spaces, maximum of 50 characters" }
  validates :title, presence: true
  validates :content, presence: true

  has_many :comments
  has_many :post_category_ships
  has_many :categories, through: :post_category_ships
  belongs_to :user, optional: true
  mount_uploader :image, ImageUploader

  def destroy
    update(deleted_at: Time.now)
  end
end

# kapag 10 post bawal na mag create ng post pa