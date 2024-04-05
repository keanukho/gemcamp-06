class Post < ApplicationRecord
  # validates :title, format: { with: /\A[a-zA-Z\s]{1,8}\z/, message: "only allows letters and spaces, maximum of 8 characters" }
  # validates :content, format: { with: /\A[a-zA-Z\s]{1,50}\z/, message: "only allows letters and spaces, maximum of 50 characters" }
  has_many :comments
end


#kapag 10 post bawal na mag create ng post pa