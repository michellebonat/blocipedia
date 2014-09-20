require 'rails_helper'

describe Wiki do
  describe "user association methods" do

    before do
      @owner = create(:user)
      @wiki = create(:wiki, owner: @owner)
    end

    describe "owner" do
      it "returns the wiki's owner" do
        expect(@wiki.owner).to eq @owner
      end
    end
  end
end
