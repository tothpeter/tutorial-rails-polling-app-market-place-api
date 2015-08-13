require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do
  describe "GET #show" do
    before(:each) do 
      @product = FactoryGirl.create :product
      get :show, id: @product.id
    end

    it "returns the information about a reporter on a hash" do
      product_response = json_response
      expect(product_response[:data][:attributes][:title]).to eql @product.title
    end

    it { should respond_with 200 }
  end

  describe "GET #index" do
    before(:each) do
      user = FactoryGirl.create :user
      4.times { FactoryGirl.create :product, user: user } 
      get :index
    end

    it "returns 4 records from the database" do
      products_response = json_response
      expect(products_response[:data].length).to eq 4
    end

    it { should respond_with 200 }
  end
end
