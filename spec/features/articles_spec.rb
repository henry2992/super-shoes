require 'spec_helper'
require 'rails_helper'

describe 'Articles' do

  describe 'Create a New article' do
    
    it 'Adds a new article and displays the results' do

      FactoryGirl.create(:store)

      visit ('/articles')

      expect{
        click_link 'New Article'
        fill_in 'Name', with: 'Some article name'
        fill_in 'Description', with: 'Some name'
        fill_in 'Price', with: 60
        fill_in 'Total in shelf', with: 5
        fill_in 'Total in vault', with: 8
        select 'New Store', from: 'article_store_id'
        click_button 'Create Article'
      }.to change(Article,:count).by(1)
      expect(page).to have_content 'Article was successfully created.'
      expect(page).to have_content 'Some article name'

    end
  end
end


