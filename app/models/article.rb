class Article < ActiveRecord::Base
  belongs_to :user
  has_many :article_tags
  has_many :tags, through: :article_tags
  validates :title, presence: true, length: {minimum: 3, maximum: 50}
  validates :description, presence: true, length: {minimum: 10, maximum: 300}
  validates :user_id, presence: true
  def tag_list
    tags.pluck(:name).join(", ") 
  end
  
  def tag_list=(tags_string)
    self.tags = tags_string.split(", ").map { |name| Tag.find_or_create_by(name: name) }
    # tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
    # new_or_found_tags = tags_string.map { |name| Tag.find_or_create_by(name: name) }
    
  end
  
end