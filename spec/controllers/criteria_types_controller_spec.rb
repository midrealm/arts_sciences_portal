require 'rails_helper'

RSpec.describe CriteriaTypesController, type: :controller do
  describe 'authorization' do
    context "if the user is not logged in" do
      let!(:criteria_type) { CriteriaType.first || FactoryBot.create(:criteria_type, id: 1) }

      include_examples "tells user to login", :index
      include_examples "tells user to login", :edit, {id: 1}
      include_examples "tells user to login", :show, {id: 1}

      it 'denies user to destroy criteria types' do
        post :destroy, params: {id: criteria_type.id}
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq "You need to sign in or sign up before continuing."
      end

      it "denies user to update criteria types" do
        post :update, params: {id: criteria_type.id, criteria_type: {description: 'test'}}
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq "You need to sign in or sign up before continuing."
      end
    end

    context "if the user is in the correct group" do
      let!(:criteria_type) { CriteriaType.first || FactoryBot.create(:criteria_type, id: 1) }

      before(:each) do
        login_admin
      end

      include_examples "grants access", :index
      include_examples "grants access", :edit, {id: 1}
      include_examples "grants access", :show, {id: 1}

      it 'allows admin to destroy criteria types' do
        criteria_type = FactoryBot.create(:criteria_type)
        post :destroy, params: {id: criteria_type.id}
        expect(response.status).to eq 302
        expect(flash[:notice]).to be_present
      end

      it "allows admin to update criteria types" do
        post :update, params: {id: 1, criteria_type: {description: 'test'}}
        expect(response.status).to eq 302
        expect(flash[:notice]).to be_present
      end
    end
  end

  describe "GET #index" do
    subject(:index) {get :index}

    let!(:criteria_type1) {FactoryBot.create(:criteria_type, description: 'criteria_type 1')}
    let!(:criteria_type2) {FactoryBot.create(:criteria_type, description: 'criteria_type 2')}

    before(:each) do
      stub_login
      index
    end

    render_views

    it 'returns a "success" status code' do
      expect(response.code).to eq('200')
    end

    it 'lists out all entries' do
      expect(response.body).to include(criteria_type1.description)
      expect(response.body).to include(criteria_type2.description)
    end
  end

  describe "GET #show" do
    subject(:show) {get :show, params: {id: criteria_type.id}}

    let!(:criteria_type) { FactoryBot.create(:criteria_type) }

    before(:each) do
      stub_login
      show
    end

    render_views

    it 'returns a "success" status code' do
      expect(response.code).to eq('200')
    end

    it 'lists out criteria type' do
      expect(response.body).to include(criteria_type.description)
    end
  end

  describe "GET #edit" do
    subject(:edit) {get :edit, params: {id: criteria_type.id}}

    let!(:criteria_type) { FactoryBot.create(:criteria_type) }

    before(:each) do
      stub_login
      edit
    end

    render_views

    it 'returns a "success" status code' do
      expect(response.code).to eq('200')
    end

    it 'has the existing criteria_type description' do
      expect(response.body).to include(criteria_type.description)
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      subject(:update) {post :update, params: {id: criteria_type.id, criteria_type: {description: 'updated'}}}

      let!(:criteria_type) {FactoryBot.create(:criteria_type, description: 'my criteria_type')}

      before(:each) do
        stub_login
        update
      end

      it 'updated the existing criteria type description' do
        criteria_type.reload
        expect(criteria_type.description).to eq 'updated'
      end

      it "redirects to the criteria type" do
        put :update, params: {id: criteria_type.to_param, criteria_type: {description: 'updated'}}
        expect(response).to redirect_to(criteria_type)
      end
    end
  end

  describe "DELETE #destroy" do
    subject(:destroy) {post :destroy, params: {id: criteria_type.id}}

    let!(:criteria_type) {FactoryBot.create(:criteria_type, description: 'delete me')}

    before(:each) do
      stub_login
      destroy
    end

    it 'updated the existing criteria type description' do
      descriptions = CriteriaType.pluck(:description)
      expect(descriptions).to_not include 'delete me'
    end
  end
end
