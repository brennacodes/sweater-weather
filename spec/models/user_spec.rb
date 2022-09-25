require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user_1) { User.create!(email: "barry@barry.com", password: "password") }
  let!(:user_2) { User.create!(email: "jenna@jennison.com", password: "password") }

  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
  end

  it "receives a unique api_key" do
    expect(user_1.api_key).to_not be_nil
    expect(user_2.api_key).to_not be_nil
    expect(user_1.api_key).to_not eq(user_2.api_key)
  end
end
