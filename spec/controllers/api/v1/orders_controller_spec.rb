require 'rails_helper'

RSpec.describe Api::V1::OrdersController, type: :controller do
  describe "GET #index" do
    before(:each) do
      current_user = FactoryGirl.create :user
      api_authorization_header current_user.auth_token
      4.times { FactoryGirl.create :order, user: current_user }
      get :index, user_id: current_user.id
    end

    it "returns 4 order records from the user" do
      orders_response = json_response[:data]
      expect(orders_response.length).to eq 4
    end

    it { should respond_with 200 }
  end

  describe "GET #show" do
    before(:each) do
      current_user = FactoryGirl.create :user
      api_authorization_header current_user.auth_token

      @product = FactoryGirl.create :product, user: current_user
      @order = FactoryGirl.create :order, user: current_user, product_ids: [@product.id]
      get :show, user_id: current_user.id, id: @order.id
    end

    it "returns the user order record matching the id" do
      order_response = json_response[:data]
      expect(order_response[:id]).to eql @order.id.to_s
    end

    it "includes the total for the order" do
      order_response = json_response[:data]
      expect(order_response[:attributes][:total]).to eql @order.total.to_s
    end

    it "includes the products on the order" do
      order_response = json_response[:data]
      expect(order_response[:relationships][:products][:data].length).to eq 1
    end

    it { should respond_with 200 }
  end
end
