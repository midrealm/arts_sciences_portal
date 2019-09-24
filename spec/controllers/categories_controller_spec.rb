require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe 'authorization' do
    context "if the user is not logged in" do
      let!(:category) { FactoryBot.create(:category, id: 1) }

      include_examples "tells user to login", :index
      include_examples "tells user to login", :edit, {id: 1}
      include_examples "tells user to login", :show, {id: 1}

      it 'denies user to destroy entries' do
        post :destroy, params: {id: category.id}
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq "You need to sign in or sign up before continuing."
      end

      it "denies user to update entries" do
        post :update, params: {id: category.id, category: {name: 'test'}}
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq "You need to sign in or sign up before continuing."
      end
    end

    context "if the user is in the correct group" do
      let!(:category) { FactoryBot.create(:category, id: 1) }

      before(:each) do
        login_admin
      end

      include_examples "grants access", :index
      include_examples "grants access", :edit, {id: 1}
      include_examples "grants access", :show, {id: 1}

      it 'allows admin to destroy users' do
        category = FactoryBot.create(:category)
        post :destroy, params: {id: category.id}
        expect(response.status).to eq 302
        expect(flash[:notice]).to be_present
      end

      it "allows admin to update entries" do
        post :update, params: {id: 1, category: {name: 'test'}}
        expect(response.status).to eq 302
        expect(flash[:notice]).to be_present
      end
    end
  end

  describe "GET #index" do
    subject(:index) {get :index}

    let!(:category1) {FactoryBot.create(:category, name: 'category 1')}
    let!(:category2) {FactoryBot.create(:category, name: 'category 2')}

    before(:each) do
      stub_login
      index
    end

    render_views

    it 'returns a "success" status code' do
      expect(response.code).to eq('200')
    end

    it 'lists out all entries' do
      expect(response.body).to include(category1.name)
      expect(response.body).to include(category2.name)
    end
  end

  describe "GET #show" do
    subject(:show) {get :show, params: {id: category.id}}

    let!(:category) { FactoryBot.create(:category) }

    before(:each) do
      stub_login
      show
    end

    render_views

    it 'returns a "success" status code' do
      expect(response.code).to eq('200')
    end

    it 'lists out category' do
      expect(response.body).to include(category.name)
    end
  end

  describe "GET #edit" do
    subject(:edit) {get :edit, params: {id: category.id}}

    let!(:category) { FactoryBot.create(:category) }

    before(:each) do
      stub_login
      edit
    end

    render_views

    it 'returns a "success" status code' do
      expect(response.code).to eq('200')
    end

    it 'has the existing category name' do
      expect(response.body).to include(category.name)
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      subject(:update) {post :update, params: {id: category.id, category: {name: 'updated'}}}

      let!(:category) {FactoryBot.create(:category, name: 'my category')}

      before(:each) do
        stub_login
        update
      end

      it 'updated the existing category name' do
        category.reload
        expect(category.name).to eq 'updated'
      end

      it "redirects to the category" do
        put :update, params: {id: category.to_param, category: {name: 'updated'}}
        expect(response).to redirect_to(category)
      end
    end
  end

  describe "DELETE #destroy" do
    subject(:destroy) {post :destroy, params: {id: category.id}}

    let!(:category) {FactoryBot.create(:category, name: 'delete me')}

    before(:each) do
      stub_login
      destroy
    end

    it 'updated the existing role name' do
      names = Category.pluck(:name)
      expect(names).to_not include 'delete me'
    end
  end
end
