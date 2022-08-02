require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should belong_to :supermarket }
    it { should have_many :customer_items }
    it { should have_many(:items).through(:customer_items) }
  end

  describe 'instance methods' do
    it 'can calculate total price of items' do
      market = Supermarket.create!(name: 'Fresh Market', location: 'Central Town Center')
      customer = market.customers.create!(name: 'Basil')
      customer2 = market.customers.create!(name: 'Basil')
      item1 = market.items.create!(name: 'One Egg', price: 1)
      item2 = market.items.create!(name: 'Pineapple', price: 4)
      item3 = market.items.create!(name: 'Baguette', price: 3)

      customer_item1 = CustomerItem.create!(customer: customer, item: item1)
      customer_item2 = CustomerItem.create!(customer: customer, item: item2)
      customer_item3 = CustomerItem.create!(customer: customer2, item: item3)

      expect(customer.total_price).to eq(5)
      expect(customer2.total_price).to eq(3)
    end
  end
end

