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
end
