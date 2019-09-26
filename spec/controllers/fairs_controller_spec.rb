require 'rails_helper'

RSpec.describe FairsController, type: :controller do
  describe 'authorization' do
    context "if the user is not logged in" do
      let!(:fair) { Fair.first || FactoryBot.create(:fair, id: 1) }

      include_examples "tells user to login", :index
      include_examples "tells user to login", :edit, {id: 1}
      include_examples "tells user to login", :show, {id: 1}

      it 'denies user to destroy fairs' do
        post :destroy, params: {id: fair.id}
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq "You need to sign in or sign up before continuing."
      end

      it "denies user to update fair" do
        post :update, params: {id: fair.id, fair: {name: 'updated'}}
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq "You need to sign in or sign up before continuing."
      end
    end

    context "if the user is in the correct group" do
      let!(:fair) { Fair.first || FactoryBot.create(:fair, id: 1) }

      before(:each) do
        login_admin
      end

      include_examples "grants access", :index
      include_examples "grants access", :edit, {id: 1}
      include_examples "grants access", :show, {id: 1}

      it 'allows admin to destroy fairs' do
        fair = FactoryBot.create(:fair)
        post :destroy, params: {id: fair.id}
        expect(response.status).to eq 302
        expect(flash[:notice]).to be_present
      end

      it "allows admin to update fairs" do
        post :update, params: {id: 1, fair: {name: 'updated'}}
        expect(response.status).to eq 302
        expect(flash[:notice]).to be_present
      end
    end
  end

  describe "GET #index" do
    subject(:index) {get :index}

    let!(:fair1) {FactoryBot.create(:fair, name: 'fair 1')}
    let!(:fair2) {FactoryBot.create(:fair, name: 'fair 2')}

    before(:each) do
      stub_login
      index
    end

    render_views

    it 'returns a "success" status code' do
      expect(response.code).to eq('200')
    end

    it 'lists out all fairs' do
      expect(response.body).to include(fair1.name)
      expect(response.body).to include(fair2.name)
    end
  end

  describe "GET #show" do
    subject(:show) {get :show, params: {id: fair.id}}

    let!(:fair) { FactoryBot.create(:fair) }

    before(:each) do
      stub_login
      show
    end

    render_views

    it 'returns a "success" status code' do
      expect(response.code).to eq('200')
    end

    it 'lists out fairs' do
      expect(response.body).to include(fair.name)
    end
  end

  describe "GET #edit" do
    subject(:edit) {get :edit, params: {id: fair.id}}

    let!(:fair) { FactoryBot.create(:fair) }

    before(:each) do
      stub_login
      edit
    end

    render_views

    it 'returns a "success" status code' do
      expect(response.code).to eq('200')
    end

    it 'has the existing fair date' do
      expect(response.body).to include(fair.name)
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      subject(:update) {post :update, params: {id: fair.id, fair: {name: 'updated'}}}

      let!(:fair) {FactoryBot.create(:fair)}

      before(:each) do
        stub_login
        update
      end

      it 'updated the existing fair date' do
        fair.reload
        expect(fair.name).to eq 'updated'
      end

      it "redirects to the fair" do
        put :update, params: {id: fair.to_param, fair: {name: 'updated'}}
        expect(response).to redirect_to(fair)
      end
    end
  end

  describe "DELETE #destroy" do
    subject(:destroy) {post :destroy, params: {id: fair.id}}

    let!(:fair) {FactoryBot.create(:fair, name: 'delete me')}

    before(:each) do
      stub_login
      destroy
    end

    it 'updated the existing region' do
      names = Fair.pluck(:name)
      expect(names).to_not include 'delete me'
    end
  end
end
