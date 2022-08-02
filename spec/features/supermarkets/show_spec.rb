require 'rails_helper'

RSpec.describe 'supermarket show page' do
  it 'displays supermarket name' do
    market = Supermarket.create!(name: 'Fresh Market', location: 'Central Town Center')
    market2 = Supermarket.create!(name: 'Buy Things', location: 'Central Town Center')

    visit "/supermarkets/#{market.id}"

    within '#header' do
      expect(page).to have_content('Fresh Market')
      expect(page).to_not have_content('Buy Things')
    end
  end

  it 'has link to supermarkets item index page' do
    market = Supermarket.create!(name: 'Fresh Market', location: 'Central Town Center')
    market2 = Supermarket.create!(name: 'Buy Things', location: 'Central Town Center')

    item1 = market.items.create!(name: 'One Egg', price: 1)
    item2 = market.items.create!(name: 'Pineapple', price: 4)
    item3 = market2.items.create!(name: 'Baguette', price: 3)

    visit "/supermarkets/#{market.id}"

    within '#view-items-link' do
      expect(page).to have_link('View All Items')
    end
  end

  it 'lists the three most popular items' do
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

    visit "/supermarkets/#{market.id}"

    within '#popular-items' do
      expect(page).to have_content('One Egg')
      expect(page).to have_content('Baguette')
      expect(page).to have_content('Pineapple')
      expect(page).to_not have_content('Turkey')
    end
  end
end
