require 'rails_helper'

RSpec.describe 'User Index', type: :system do
  before :each do
    User.make(email: 'moin@email.com', password: '123456')
  end
  context 'after creating a user' do
    it "signs me in" do
      visit new_user_session_path
      within("#session") do
        fill_in 'Email', with: 'moin@email.com'
        fill_in 'Password', with: '123456'
      end
      click_button 'Sign in'
      expect(page).to have_content('Name: Moin')
    end
  end
end