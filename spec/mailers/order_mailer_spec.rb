require 'rails_helper'

RSpec.describe OrderMailer do
  include Rails.application.routes.url_helpers

  describe ".send_confirmation" do
    before(:all) do
      user = FactoryGirl.build :user
      @order = FactoryGirl.build :order, user: user
      @user = @order.user
      @mail = OrderMailer.send_confirmation(@order)
    end

    it "should be set to be delivered to the user from the order passed in" do
      expect(@mail.to).to eql([@user.email])
    end

    it "should be set to be send from no-reply@marketplace.com" do
      expect(@mail.from).to eql(['no-reply@marketplace.com'])
    end

    it "should contain the user's message in the mail body" do
      expect(@mail.body.encoded).to match /Order: ##{@order.id}/
    end

    it "should have the correct subject" do
      expect(@mail.subject).to eql('Order Confirmation')
    end

    it "should have the products count" do
      expect(@mail.body.encoded).to match /You ordered #{@order.products.count} products:/
    end
  end
end
