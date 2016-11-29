require 'rails_helper'

describe 'items endpoints' do
  context "GET /items" do
    it "returns a list of all items" do

      create_list(:item, 3)

      get '/api/v1/items'
      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items.count).to eq(3)
    end

    it "returns the show page for one item" do
      item = create(:item)

      get "/api/v1/items/#{item.id}"
      item_show = JSON.parse(response.body)

      expect(response).to be_success
      expect(item_show["name"]).to eq(item.name)
    end

  end

  context "POST /items" do
    it "creates a new item" do
      expect{
        post "/api/v1/items",
          params: {name: "New Thing", price: 20}
      }.to change{Item.count}.by(1)

      expect(response).to be_success
    end
  end
end
