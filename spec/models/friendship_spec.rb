require 'rails_helper'

RSpec.describe Friendship, type: :model do
  it "should belong to a user" do
    t = Friendship.reflect_on_association(:user)
    expect(t.macro).to eq(:belongs_to)
  end
end