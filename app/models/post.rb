class Post < ApplicationRecord
  before_create :set_slug

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  def to_param
    slug
  end

  def all_tags=(names)
    self.tags = names.split(',').map do |name|
      Tag.where(name: name).first_or_create!
    end
  end

  def all_tags
    tags.map(&:name).join(', ')
  end

  def tag_arr
    tags.map(&:name)
  end

  def self.tagged_with(name)
    Tag.find_by!(name: name).posts rescue nil
  end

  private

  def set_slug
    self.slug = self.title.downcase.parameterize
    t = Time.now
    hour = t.strftime('%H')
    min = t.strftime('%M')

    if Post.where(:slug => self.slug).count == 0
      self.slug = self.title.downcase.parameterize
    else
      self.slug = self.title.downcase.parameterize + '-' + hour + min
    end
  end
end
