# this needs to be updated
# require 'rails_helper'
#
# describe User do
#
#   describe "user can only see their wikis" do
#
#     before do
#       @user = create(:user)
#       @todo = create(:todo, user: @user)
#
#       @user2 = create(:user)
#       @todo = create(:todo, user: @user2)
#       2.times { create(:todo, user: @user2) }
#     end
#
#     describe "visible to user" do
#
#       it "returns only that user's wikis" do
#         users = User.first
#         expect(@user.wiki.count).to eq(1)
#       end
#     end
#   end
# end