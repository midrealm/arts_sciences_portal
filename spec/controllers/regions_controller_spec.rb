require 'rails_helper'

RSpec.describe RegionsController, type: :controller do
  describe 'authorization' do
    context "if the user is not logged in" do
      let!(:region) { Region.first || FactoryBot.create(:region, id: 1) }

      include_examples "tells user to login", :index
      include_examples "tells user to login", :edit, {id: 1}
      include_examples "tells user to login", :show, {id: 1}

      it 'denies user to destroy regions' do
        post :destroy, params: {id: region.id}
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq "You need to sign in or sign up before continuing."
      end

      it "denies user to update regions" do
        post :update, params: {id: region.id, category: {name: 'test'}}
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq "You need to sign in or sign up before continuing."
      end
    end

    context "if the user is in the correct group" do
      let!(:category) { Region.first || FactoryBot.create(:region, id: 1) }

      before(:each) do
        login_admin
      end

      include_examples "grants access", :index
      include_examples "grants access", :edit, {id: 1}
      include_examples "grants access", :show, {id: 1}

      it 'allows admin to destroy regions' do
        region = FactoryBot.create(:region)
        post :destroy, params: {id: region.id}
        expect(response.status).to eq 302
        expect(flash[:notice]).to be_present
      end

      it "allows admin to update regions" do
        post :update, params: {id: 1, region: {name: 'test'}}
        expect(response.status).to eq 302
        expect(flash[:notice]).to be_present
      end
    end
  end

  describe "GET #index" do
    subject(:index) {get :index}

    let!(:region1) {FactoryBot.create(:region, name: 'region 1')}
    let!(:region2) {FactoryBot.create(:region, name: 'region 2')}

    before(:each) do
      stub_login
      index
    end

    render_views

    it 'returns a "success" status code' do
      expect(response.code).to eq('200')
    end

    it 'lists out all entries' do
      expect(response.body).to include(region1.name)
      expect(response.body).to include(region2.name)
    end
  end

  describe "GET #show" do
    subject(:show) {get :show, params: {id: region.id}}

    let!(:region) { FactoryBot.create(:region) }

    before(:each) do
      stub_login
      show
    end

    render_views

    it 'returns a "success" status code' do
      expect(response.code).to eq('200')
    end

    it 'lists out regions' do
      expect(response.body).to include(region.name)
    end
  end

  describe "GET #edit" do
    subject(:edit) {get :edit, params: {id: region.id}}

    let!(:region) { FactoryBot.create(:region) }

    before(:each) do
      stub_login
      edit
    end

    render_views

    it 'returns a "success" status code' do
      expect(response.code).to eq('200')
    end

    it 'has the existing category name' do
      expect(response.body).to include(region.name)
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      subject(:update) {post :update, params: {id: region.id, region: {name: 'updated'}}}

      let!(:region) {FactoryBot.create(:region, name: 'my region')}

      before(:each) do
        stub_login
        update
      end

      it 'updated the existing region name' do
        region.reload
        expect(region.name).to eq 'updated'
      end

      it "redirects to the region" do
        put :update, params: {id: region.to_param, region: {name: 'updated'}}
        expect(response).to redirect_to(region)
      end
    end
  end

  describe "DELETE #destroy" do
    subject(:destroy) {post :destroy, params: {id: region.id}}

    let!(:region) {FactoryBot.create(:region, name: 'delete me')}

    before(:each) do
      stub_login
      destroy
    end

    it 'updated the existing region' do
      names = Region.pluck(:name)
      expect(names).to_not include 'delete me'
    end
  end
end
