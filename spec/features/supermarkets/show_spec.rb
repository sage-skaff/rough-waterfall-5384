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
end
