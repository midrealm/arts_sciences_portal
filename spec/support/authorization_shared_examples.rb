RSpec.shared_examples "denies access to user" do |path, params = {}|
  it "gives the user a 403" do
    get path, params: params
    expect(response.status).to eq 302
    expect(flash[:alert]).to eq "You are not authorized to perform this action."
  end
end

RSpec.shared_examples "grants access" do |path, params = {}|
  it "allows the user to see the requested page" do
    get path, params: params
    expect(response.status).to eq 200
  end
end
