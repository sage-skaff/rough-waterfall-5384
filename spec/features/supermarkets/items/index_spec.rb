require 'rails_helper'

RSpec.describe 'supermarkets item index page' do
  it 'links from supermarkets show page' do
    market = Supermarket.create!(name: 'Fresh Market', location: 'Central Town Center')

    visit "/supermarkets/#{market.id}"

    within '#view-items-link' do
      click_link 'View All Items'
    end

    expect(current_path).to eq("/supermarkets/#{market.id}/items")
  end

  it 'lists all items the supermarket has' do
    market = Supermarket.create!(name: 'Fresh Market', location: 'Central Town Center')
    market2 = Supermarket.create!(name: 'Buy Things', location: 'Central Town Center')

    item1 = market.items.create!(name: 'One Egg', price: 1)
    item2 = market.items.create!(name: 'Pineapple', price: 4)
    item3 = market2.items.create!(name: 'Baguette', price: 3)

    visit "/supermarkets/#{market.id}/items"

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
end
