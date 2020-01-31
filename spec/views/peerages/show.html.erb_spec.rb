require 'rails_helper'

RSpec.describe "peerages/show", type: :view do
  before(:each) do
    @peerage = assign(:peerage, Peerage.create!(
      :description => "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Description/)
  end
end
