class Supermarket < ApplicationRecord
  has_many :customers
  has_many :items

  def three_most_popular_items
    items.joins(:customers).group(:id).order('count(customers.id) desc').limit(3)
  end
end
