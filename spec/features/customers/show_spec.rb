require 'rails_helper'

RSpec.describe 'customer show page' do
  it 'lists customers items' do
    market = Supermarket.create!(name: 'Fresh Market', location: 'Central Town Center')
    customer = market.customers.create!(name: 'Basil')
    item1 = market.items.create!(name: 'One Egg', price: 1)
    item2 = market.items.create!(name: 'Pineapple', price: 4)
    item3 = market.items.create!(name: 'Baguette', price: 3)

    customer_item1 = CustomerItem.create!(customer: customer, item: item1)
    customer_item2 = CustomerItem.create!(customer: customer, item: item2)

    visit "/customers/#{customer.id}"

    within "#item-#{item1.id}" do
      expect(page).to have_content('One Egg')
      expect(page).to_not have_content('Pineapple')
      expect(page).to_not have_content('Baguette')
    end

    within "#item-#{item2.id}" do
      expect(page).to have_content('Pineapple')
      expect(page).to_not have_content('One Egg')
      expect(page).to_not have_content('Baguette')
    end
  end

  it 'list name of supermarket customer belongs to' do
    market = Supermarket.create!(name: 'Fresh Market', location: 'Central Town Center')
    market2 = Supermarket.create!(name: 'Grocery Store', location: 'Central Town Center')
    customer = market.customers.create!(name: 'Basil')

    visit "/customers/#{customer.id}"

    within '#supermarket' do
      expect(page).to have_content('Fresh Market')
      expect(page).to_not have_content('Grocery Store')
    end
  end
end
