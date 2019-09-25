require 'rails_helper'

RSpec.describe "fairs/show", type: :view do
  before(:each) do
    @fair = assign(:fair, Fair.create!(
      :region => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
  end
end
