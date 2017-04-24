class Post < ApplicationRecord
  validates :author, :post_subs, :title, presence: true

  belongs_to :author, foreign_key: :user_id, class_name: :User
  has_many :post_subs
  has_many :subs, through: :post_subs
  has_many :comments
  has_many :votes, as: :votable

  attr_reader :score

  def comments_by_parent_id
    children = Hash.new { |h, k| h[k] = [] }
    self.comments.each do |comment|
      children[comment.parent_comment_id] << comment
    end
    children

  end

  def score
    @score = 0
    self.votes.each {|vote| @score += vote.value.to_i}
    @score
  end
end
