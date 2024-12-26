require 'rails_helper'

RSpec.describe "GET /", type: :request do
  it "return success" do
    get root_path

    expect(response).to be_successful
  end
end
