require 'rails_helper'

RSpec.describe Supermarket, type: :model do
  describe 'relationships' do
    it { should have_many :customers }
    it { should have_many :items }
  end

  describe 'instance methods' do
    it 'can show the three most popular items in the supermarket' do
      market = Supermarket.create!(name: 'Fresh Market', location: 'Central Town Center')
      customer = market.customers.create!(name: 'Basil')
      customer2 = market.customers.create!(name: 'Thyme')
      customer3 = market.customers.create!(name: 'Rosemary')
      item1 = market.items.create!(name: 'One Egg', price: 1)
      item2 = market.items.create!(name: 'Pineapple', price: 4)
      item3 = market.items.create!(name: 'Baguette', price: 3)
      item4 = market.items.create!(name: 'Turkey', price: 6)

      customer_item1 = CustomerItem.create!(customer: customer, item: item1)
      customer_item2 = CustomerItem.create!(customer: customer, item: item2)
      customer_item3 = CustomerItem.create!(customer: customer2, item: item3)
      customer_item4 = CustomerItem.create!(customer: customer2, item: item2)
      customer_item5 = CustomerItem.create!(customer: customer3, item: item2)
      customer_item6 = CustomerItem.create!(customer: customer3, item: item1)

      expect(market.three_most_popular_items).to eq([item2, item1, item3])
    end
  end
end
