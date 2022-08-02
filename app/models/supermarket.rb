class Supermarket < ApplicationRecord
  has_many :customers
  has_many :items
end

