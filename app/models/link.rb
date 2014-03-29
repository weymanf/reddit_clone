class Link < ActiveRecord::Base
  validates :title, :url, :presence => true

  has_many :subs, :through => :links_subs
  has_many :links_subs
  belongs_to :user
  has_many :comments
  has_many :user_votes


  def comments_by_parent_id
    @comments = self.comments
    comment_map = {}

    @comments.each do |comment|
      comment_map[comment.id] = @comments.where("parent_comment_id = #{comment.id}")
    end
    comment_map
  end

  def parent_comments
    self.comments.where("parent_comment_id IS NULL")
  end
end
