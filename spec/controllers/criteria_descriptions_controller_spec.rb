require 'rails_helper'

RSpec.describe CriteriaDescriptionsController, type: :controller do
  describe 'authorization' do
    context "if the user is not logged in" do
      let!(:criteria_description) { CriteriaDescription.first || FactoryBot.create(:criteria_description, id: 1) }

      include_examples "tells user to login", :index
      include_examples "tells user to login", :edit, {id: 1}
      include_examples "tells user to login", :show, {id: 1}

      it 'denies user to destroy criteria descriptions' do
        post :destroy, params: {id: criteria_description.id}
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq "You need to sign in or sign up before continuing."
      end

      it "denies user to update criteria descriptions" do
        post :update, params: {id: criteria_description.id, criteria_description: {description: 'test'}}
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq "You need to sign in or sign up before continuing."
      end
    end

    context "if the user is in the correct group" do
      let!(:criteria_description) { CriteriaDescription.first || FactoryBot.create(:criteria_description, id: 1) }

      before(:each) do
        login_admin
      end

      include_examples "grants access", :index
      include_examples "grants access", :edit, {id: 1}
      include_examples "grants access", :show, {id: 1}

      it 'allows admin to destroy criteria descriptions' do
        criteria_description = FactoryBot.create(:criteria_description)
        post :destroy, params: {id: criteria_description.id}
        expect(response.status).to eq 302
        expect(flash[:notice]).to be_present
      end

      it "allows admin to update criteria descriptions" do
        post :update, params: {id: 1, criteria_description: {description: 'test'}}
        expect(response.status).to eq 302
        expect(flash[:notice]).to be_present
      end
    end
  end

  describe "GET #index" do
    subject(:index) {get :index}

    let!(:criteria_description1) {FactoryBot.create(:criteria_description, description: 'criteria_description 1')}
    let!(:criteria_description2) {FactoryBot.create(:criteria_description, description: 'criteria_description 2')}

    before(:each) do
      stub_login
      index
    end

    render_views

    it 'returns a "success" status code' do
      expect(response.code).to eq('200')
    end

    it 'lists out all criteria descriptions' do
      expect(response.body).to include(criteria_description1.description)
      expect(response.body).to include(criteria_description2.description)
    end
  end

  describe "GET #show" do
    subject(:show) {get :show, params: {id: criteria_description.id}}

    let!(:criteria_description) { FactoryBot.create(:criteria_description) }

    before(:each) do
      stub_login
      show
    end

    render_views

    it 'returns a "success" status code' do
      expect(response.code).to eq('200')
    end

    it 'lists out criteria descriptions' do
      expect(response.body).to include(criteria_description.description)
    end
  end

  describe "GET #edit" do
    subject(:edit) {get :edit, params: {id: criteria_description.id}}

    let!(:criteria_description) { FactoryBot.create(:criteria_description) }

    before(:each) do
      stub_login
      edit
    end

    render_views

    it 'returns a "success" status code' do
      expect(response.code).to eq('200')
    end

    it 'has the existing criteria description name' do
      expect(response.body).to include(criteria_description.description)
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      subject(:update) {post :update, params: {id: criteria_description.id, criteria_description: {description: 'updated'}}}

      let!(:criteria_description) {FactoryBot.create(:criteria_description, description: 'my criteria_description')}

      before(:each) do
        stub_login
        update
      end

      it 'updated the existing criteria description' do
        criteria_description.reload
        expect(criteria_description.description).to eq 'updated'
      end

      it "redirects to the criteria description" do
        put :update, params: {id: criteria_description.to_param, criteria_description: {description: 'updated'}}
        expect(response).to redirect_to(criteria_description)
      end
    end
  end

  describe "DELETE #destroy" do
    subject(:destroy) {post :destroy, params: {id: criteria_description.id}}

    let!(:criteria_description) {FactoryBot.create(:criteria_description, description: 'delete me')}

    before(:each) do
      stub_login
      destroy
    end

    it 'updated the existing criteria description' do
      descriptions = CriteriaDescription.pluck(:description)
      expect(descriptions).to_not include 'delete me'
    end
  end
end
