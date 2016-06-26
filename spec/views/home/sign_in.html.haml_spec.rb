require "rails_helper"

describe "home/sign_in" do
  it "gives instructions to new users" do
    render
    expect(rendered).to match(/How Home Sharing Works/)
  end
end
