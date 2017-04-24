class Comment < ApplicationRecord
  validates :author, :post, :content, presence: true

  belongs_to :author, foreign_key: :user_id, class_name: :User
  belongs_to :post
  has_many :child_comments, foreign_key: :parent_comment_id, class_name: :Comment
  has_many :votes, as: :votable

  attr_reader :score

  def score
    @score = 0
    self.votes.each {|vote| @score += vote.value.to_i}
    @score
  end
end
