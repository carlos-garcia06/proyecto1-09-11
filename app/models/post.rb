class Post < ApplicationRecord
  belongs_to :user
  validates :image, presence: true
  validates :description, presence: true, length: { minimum: 10 }

  has_one_attached :image do |attachable|
    attachable.variant :large, resize_to_limit: [600, 600]
    attachable.variant :medium, resize_to_limit: [300, 300]
    attachable.variant :thumb, resize_to_limit: [150, 150]
  end

  validate :image_must_be_image

  def image_must_be_image
    if image.attached? && !image.content_type.start_with?("image/")
      errors.add(:image, "debe ser una imagen")
    end
  end
end
