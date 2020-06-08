require 'rails_helper'

RSpec.describe 'User Index', type: :system do
  before :each do
    User.create(name: 'Moin', email: 'moin@email.com', password: '123456')
  end
  context 'after creating a user' do
    it 'signs me in' do
      visit new_user_session_path
      within('#new_user') do
        fill_in 'Email', with: 'moin@email.com'
        fill_in 'Password', with: '123456'
      end
      click_button 'Log in'
      visit users_path
      expect(page).to have_content('Name: Moin')
    end
  end
end
