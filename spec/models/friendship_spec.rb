require 'rails_helper'

RSpec.describe Friendship, type: :model do
  it 'should belong to a user' do
    t = Friendship.reflect_on_association(:user)
    expect(t.macro).to eq(:belongs_to)
  end

  context 'when two friends have a mutual' do
    let(:u1) {User.create(name: 'Moin', email:  'test1@email.com', password: '1234rwge56')}
    let(:u2) {User.create(name: 'Alvaro', email:  'test2@email.com', password: '1234grs56')}
    let(:u3) {User.create(name: 'Third', email:  'test3@email.com', password: '1234gwr56')}
    it  'returns the mutual users' do
      u1.friendships.create(user_id: u1.id, friend_id: u2.id, confirmed: true)
      u2.friendships.create(user_id: u2.id, friend_id: u3.id, confirmed: true)
      u1.friendships.create(user_id: u1.id, friend_id: u3.id, confirmed: true)
      expect(u1.friendships.first.mutuals).to eql([u3])
    end
  end
end
