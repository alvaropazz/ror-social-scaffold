require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should have many friendships' do
    t = User.reflect_on_association(:friendships)
    expect(t.macro).to eq(:has_many)
  end

  context 'when friend does not exist' do
    it 'should return false' do
      u1 = User.new(name: 'exampleName', email: 'example@mail.com', password: '123456')
      expect(u1.friend?('u2')).to eq(false)
    end
  end

  it "should return an array of 'friends'" do
    u1 = User.create(name: 'exampleName', email: 'example@mail.com', password: '123456')
    u2 = User.create(name: 'exampleName2', email: 'example2@mail.com', password: '123456')
    u1.friendships.create(user_id: u1.id, friend_id: u2.id, confirmed: true)
    expect(u1.friends.first).to eq(u2)
  end
end
