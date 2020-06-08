require 'rails_helper'

RSpec.describe 'Home Page', type: :system do
  context 'While visiting the home page' do
    it "page contains 'Sign in'" do
      visit root_path
      expect(page).to have_content('Sign in')
    end
  end
end
