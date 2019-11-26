require 'rails_helper'

RSpec.describe CriteriaController, type: :controller do
  describe 'authorization' do
    context "if the user is not logged in" do
      let!(:criteria) { Criterium.first || FactoryBot.create(:criterium, id: 1) }

      include_examples "tells user to login", :index
      include_examples "tells user to login", :edit, {id: 1}
      include_examples "tells user to login", :show, {id: 1}

      it 'denies user to destroy criteria' do
        post :destroy, params: {id: criteria.id}
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq "You need to sign in or sign up before continuing."
      end

      it "denies user to update criteria" do
        post :update, params: {id: criteria.id, criteria: {description: 'test'}}
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq "You need to sign in or sign up before continuing."
      end
    end

    context "if the user is in the correct group" do
      let!(:criteria) { Criterium.first || FactoryBot.create(:criterium, id: 1) }

      before(:each) do
        login_admin
      end

      include_examples "grants access", :index
      include_examples "grants access", :edit, {id: 1}
      include_examples "grants access", :show, {id: 1}

      it 'allows admin to destroy criteria' do
        criteria = FactoryBot.create(:criterium)
        post :destroy, params: {id: criteria.id}
        expect(response.status).to eq 302
        expect(flash[:notice]).to be_present
      end

      it "allows admin to update criteria" do
        post :update, params: {id: 1, criterium: {description: 'test'}}
        expect(response.status).to eq 302
        expect(flash[:notice]).to be_present
      end
    end
  end

  describe "GET #index" do
    subject(:index) {get :index}

    let!(:criteria1) {FactoryBot.create(:criterium, description: 'category 1')}
    let!(:criteria2) {FactoryBot.create(:criterium, description: 'category 2')}

    before(:each) do
      stub_login
      index
    end

    render_views

    it 'returns a "success" status code' do
      expect(response.code).to eq('200')
    end

    it 'lists out all entries' do
      expect(response.body).to include(criteria1.description)
      expect(response.body).to include(criteria2.description)
    end
  end

  describe "GET #show" do
    subject(:show) {get :show, params: {id: criteria.id}}

    let!(:criteria) { FactoryBot.create(:criterium) }

    before(:each) do
      stub_login
      show
    end

    render_views

    it 'returns a "success" status code' do
      expect(response.code).to eq('200')
    end

    it 'lists out criteria' do
      expect(response.body).to include(criteria.description)
    end
  end

  describe "GET #edit" do
    subject(:edit) {get :edit, params: {id: criteria.id}}

    let!(:criteria) { FactoryBot.create(:criterium) }

    before(:each) do
      stub_login
      edit
    end

    render_views

    it 'returns a "success" status code' do
      expect(response.code).to eq('200')
    end

    it 'has the existing criteria description' do
      expect(response.body).to include(criteria.description)
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      subject(:update) {post :update, params: {id: criteria.id, criterium: {description: 'updated'}}}

      let!(:criteria) {FactoryBot.create(:criterium, description: 'my criteria')}

      before(:each) do
        stub_login
        update
      end

      it 'updated the existing criteria description' do
        criteria.reload
        expect(criteria.description).to eq 'updated'
      end

      it "redirects to the criteria" do
        put :update, params: {id: criteria.to_param, criterium: {description: 'updated'}}
        expect(response).to redirect_to(criteria)
      end
    end
  end

  describe "DELETE #destroy" do
    subject(:destroy) {post :destroy, params: {id: criteria.id}}

    let!(:criteria) {FactoryBot.create(:criterium, description: 'delete me')}

    before(:each) do
      stub_login
      destroy
    end

    it 'updated the existing criteria description' do
      descriptions = Criterium.pluck(:description)
      expect(descriptions).to_not include 'delete me'
    end
  end
end
