require 'rails_helper'

RSpec.describe Api::ArticlesController do
  describe '#index' do
    it "returns success" do
      get :index, format: :json
      expect(response).to be_success
    end
  end
end
