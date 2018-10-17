class User < ApplicationRecord
  validates_presence_of :username
  has_many :reviews

  def self.sorted_by_reviews_count_limited_to(count, direction)
    users = select("users.*, count(reviews.id) AS total_reviews")
      .joins(:reviews)
      .group(:user_id, :id)
      .order("total_reviews #{direction}")
    users.limit(count)
  end
end
