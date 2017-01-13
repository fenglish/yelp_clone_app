class Restaurant < ApplicationRecord
  has_many :reviews, -> { extending WithUserAssociationExtension }, dependent: :destroy

  belongs_to :user
  validates :name, length: { minimum: 3 }, uniqueness: true

  def average_rating
    return 'N/A' if reviews.none?
    reviews.inject(0) {|memo, review| memo + review.rating} / reviews.length
  end

  # def average_rating
  #   return 'N/A' if reviews.none?
  #   # reviews.inject(0) {|memo, review| memo + review.rating} / reviews.count
  # end

  # def average_rating
  #   return 'N/A' if reviews.none?
  #   reviews.average(:rating)
  # end

end
