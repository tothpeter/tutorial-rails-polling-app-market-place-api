require 'rails_helper'

class Authentication
  include Authenticable

  def request;end
  def response;end
  def render args
  end
end

describe Authenticable do
  let(:authentication) { Authentication.new } 
  subject { authentication }

  describe "#current_user" do
    before do
      @user = FactoryGirl.create :user
      request.headers["Authorization"] = @user.auth_token
      allow(authentication).to receive_messages(:request => request)
    end

    it "returns the user from the authorization header" do
      expect(authentication.current_user.auth_token).to eql @user.auth_token
    end
  end

  # describe "#authenticate_with_token" do
  #   before do
  #     @user = FactoryGirl.create :user
  #     # This is comming from the book, testing a method withput calling it is PRECIOUS!

  #     # allow(authentication).to receive_messages(:current_user => nil)
  #     # allow(response).to receive_messages(:response_code => 401)
  #     # allow(response).to receive_messages(:body => {"errors" => "Not authenticated"}.to_json)
  #     # allow(authentication).to receive_messages(:response => response)
  #   end

  #   it "render a json error message" do
  #     # expect(json_response[:errors]).to eql "Not authenticated"
  #   end

    # it {  should respond_with 401 }

  describe "#authenticate_with_token" do
    before do
      allow(authentication).to receive(:current_user).and_return(nil)
      allow(authentication).to receive(:render) do |args|
        args
      end
    end

    it "returns error" do
      expect(authentication.authenticate_with_token![:json][:errors]).to eql "Not authenticated"
    end

    it "returns unauthorized status" do
      expect(authentication.authenticate_with_token![:status]).to eql :unauthorized
    end
  end

  describe "#user_signed_in?" do
    context "when there is a user on 'session'" do
      before do
        @user = FactoryGirl.create :user
        allow(authentication).to receive(:current_user).and_return(@user)
      end

      it { should be_user_signed_in }
    end

    context "when there is no user on 'session'" do
      before do
        @user = FactoryGirl.create :user
        allow(authentication).to receive(:current_user).and_return(nil)
      end

      it { should_not be_user_signed_in }
    end
  end
end