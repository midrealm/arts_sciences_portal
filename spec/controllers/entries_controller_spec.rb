require 'rails_helper'

RSpec.describe EntriesController, type: :controller do
  describe 'authorization' do
    context "if the user is not logged in" do
      let!(:entry) { FactoryBot.create(:entry, id: 1) }

      include_examples "tells user to login", :index
      include_examples "tells user to login", :edit, {id: 1}
      include_examples "tells user to login", :show, {id: 1}

      it 'denies user to destroy entries' do
        post :destroy, params: {id: entry.id}
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq "You need to sign in or sign up before continuing."
      end

      it "denies user to update entries" do
        post :update, params: {id: entry.id, entry: {description: 'test'}}
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq "You need to sign in or sign up before continuing."
      end
    end

    context "if the user is in the correct group" do
      let!(:entry) { FactoryBot.create(:entry, id: 1) }

      before(:each) do
        login_admin
      end

      include_examples "grants access", :index
      include_examples "grants access", :edit, {id: 1}
      include_examples "grants access", :show, {id: 1}

      it 'allows admin to destroy users' do
        entry = FactoryBot.create(:entry)
        post :destroy, params: {id: entry.id}
        expect(response.status).to eq 302
        expect(flash[:notice]).to be_present
      end

      it "allows admin to update entries" do
        post :update, params: {id: 1, entry: {description: 'test'}}
        expect(response.status).to eq 302
        expect(flash[:notice]).to be_present
      end
    end
  end

  describe "GET #index" do
    subject(:index) {get :index}

    let!(:entry1) {FactoryBot.create(:entry, entry_name: 'entry 1')}
    let!(:entry2) {FactoryBot.create(:entry, entry_name: 'entry 2')}

    before(:each) do
      stub_login
      index
    end

    render_views

    it 'returns a "success" status code' do
      expect(response.code).to eq('200')
    end

    it 'lists out all entries' do
      expect(response.body).to include(entry1.entry_name)
      expect(response.body).to include(entry2.entry_name)
    end
  end

  describe "GET #show" do
    subject(:show) {get :show, params: {id: entry.id}}

    let!(:entry) { FactoryBot.create(:entry) }

    before(:each) do
      stub_login
      show
    end

    render_views

    it 'returns a "success" status code' do
      expect(response.code).to eq('200')
    end

    it 'lists out entry' do
      expect(response.body).to include(entry.entry_name)
    end
  end

  describe "GET #edit" do
    subject(:edit) {get :edit, params: {id: entry.id}}

    let!(:entry) { FactoryBot.create(:entry) }

    before(:each) do
      stub_login
      edit
    end

    render_views

    it 'returns a "success" status code' do
      expect(response.code).to eq('200')
    end

    it 'has the existing entry name' do
      expect(response.body).to include(entry.entry_name)
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      subject(:update) {post :update, params: {id: entry.id, entry: {entry_name: 'updated'}}}

      let!(:entry) {FactoryBot.create(:entry, entry_name: 'my entry')}

      before(:each) do
        stub_login
        update
      end

      it 'updated the existing entry name' do
        entry.reload
        expect(entry.entry_name).to eq 'updated'
      end

      it "redirects to the entry" do
        put :update, params: {id: entry.to_param, entry: {entry_name: 'updated'}}
        expect(response).to redirect_to(entry)
      end
    end
  end

  describe "DELETE #destroy" do
    subject(:destroy) {post :destroy, params: {id: entry.id}}

    let!(:entry) {FactoryBot.create(:entry, entry_name: 'delete me')}

    before(:each) do
      stub_login
      destroy
    end

    it 'updated the existing role name' do
      names = Entry.pluck(:entry_name)
      expect(names).to_not include 'delete me'
    end
  end
end
