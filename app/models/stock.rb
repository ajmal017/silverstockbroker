class Stock < ApplicationRecord
  before_validation :generate_slug
  def generate_slug
    self.name ||= name.parameterize
  end
end
