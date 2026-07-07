require 'rails_helper'

RSpec.describe DivisionRubricsController, type: :controller do
  describe 'authorization' do
    context "if the user is not logged in" do
      include_examples "tells user to login", :index
      include_examples "tells user to login", :show, {id: 1}
    end

    context "if the user is in the correct group" do
      before(:each) do
        login_admin
      end

      include_examples "grants access", :index
      include_examples "grants access", :show, {id: 1}
    end
  end

  describe "GET #index" do
    subject(:index) { get :index }

    let!(:division) { FactoryBot.create(:division, name: 'Rubric Division') }

    before(:each) do
      stub_login
      index
    end

    render_views

    it 'returns a success status code' do
      expect(response.code).to eq('200')
    end

    it 'lists divisions to browse' do
      expect(response.body).to include(division.name)
      expect(response.body).to include('Division rubrics')
    end
  end

  describe "GET #show" do
    subject(:show) { get :show, params: {id: division.id} }

    let!(:division) { FactoryBot.create(:division, name: 'Show Division', description: 'Division details') }
    let!(:criteria_type) do
      FactoryBot.create(:criteria_type, division: division, name: 'Scope', description: 'Scope')
    end
    let!(:criterium) do
      FactoryBot.create(:criterium, criteria_type: criteria_type, description: 'Example line', suggested_score: 3)
    end

    before(:each) do
      stub_login
      show
    end

    render_views

    it 'returns a success status code' do
      expect(response.code).to eq('200')
    end

    it 'shows the division rubric hierarchy' do
      expect(response.body).to include(division.name)
      expect(response.body).to include('Scope')
      expect(response.body).to include('Example line')
    end
  end
end
