require 'rails_helper'

RSpec.describe PreferencesController, type: :controller do
  describe 'authorization' do
    context "if the user is not logged in" do
      let!(:preference) { Preference.first || FactoryBot.create(:preference, id: 1) }

      include_examples "tells user to login", :index
      include_examples "tells user to login", :edit, { id: 1 }
      include_examples "tells user to login", :show, { id: 1 }

      it 'denies user to destroy entries' do
        post :destroy, params: { id: preference.id }
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq "You need to sign in or sign up before continuing."
      end

      it "denies user to update entries" do
        post :update, params: { id: preference.id, preference: { name: 'test' } }
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq "You need to sign in or sign up before continuing."
      end
    end

    context "if the user is in the correct group" do
      let!(:preference) { Preference.first || FactoryBot.create(:preference, id: 1) }

      before(:each) do
        login_admin
      end

      include_examples "grants access", :index
      include_examples "grants access", :edit, { id: 1 }
      include_examples "grants access", :show, { id: 1 }

      it 'allows admin to destroy users' do
        preference = FactoryBot.create(:preference)
        post :destroy, params: { id: preference.id }
        expect(response.status).to eq 302
        expect(flash[:notice]).to be_present
      end

      it "allows admin to update entries" do
        post :update, params: { id: 1, preference: { name: 'test' } }
        expect(response.status).to eq 302
        expect(flash[:notice]).to be_present
      end
    end
  end

  describe "GET #index" do
    subject(:index) { get :index }

    let!(:preference1) { FactoryBot.create(:preference, name: 'category 1') }
    let!(:preference2) { FactoryBot.create(:preference, name: 'category 2') }

    before(:each) do
      stub_login
      index
    end

    render_views

    it 'returns a "success" status code' do
      expect(response.code).to eq('200')
    end

    it 'lists out all entries' do
      expect(response.body).to include(preference1.name)
      expect(response.body).to include(preference2.name)
    end
  end

  describe "GET #show" do
    subject(:show) { get :show, params: { id: preference.id } }

    let!(:preference) { FactoryBot.create(:preference) }

    before(:each) do
      stub_login
      show
    end

    render_views

    it 'returns a "success" status code' do
      expect(response.code).to eq('200')
    end

    it 'lists out category' do
      expect(response.body).to include(preference.name)
    end
  end

  describe "GET #edit" do
    subject(:edit) { get :edit, params: { id: preference.id } }

    let!(:preference) { FactoryBot.create(:preference) }

    before(:each) do
      stub_login
      edit
    end

    render_views

    it 'returns a "success" status code' do
      expect(response.code).to eq('200')
    end

    it 'has the existing category name' do
      expect(response.body).to include(preference.name)
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      subject(:update) { post :update, params: { id: preference.id, preference: { name: 'updated' } } }

      let!(:preference) { FactoryBot.create(:preference, name: 'my category') }

      before(:each) do
        stub_login
        update
      end

      it 'updated the existing category name' do
        preference.reload
        expect(preference.name).to eq 'updated'
      end

      it "redirects to the category" do
        put :update, params: { id: preference.to_param, preference: { name: 'updated' } }
        expect(response).to redirect_to(preference)
      end
    end
  end

  describe "DELETE #destroy" do
    subject(:destroy) { post :destroy, params: { id: preference.id } }

    let!(:preference) { FactoryBot.create(:preference, name: 'delete me') }

    before(:each) do
      stub_login
      destroy
    end

    it 'updated the existing role name' do
      names = Preference.pluck(:name)
      expect(names).to_not include 'delete me'
    end
  end
end
