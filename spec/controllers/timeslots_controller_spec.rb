require 'rails_helper'

RSpec.describe TimeslotsController, type: :controller do
  describe 'authorization' do
    context "if the user is not logged in" do
      let!(:timeslot) { Timeslot.first || FactoryBot.create(:timeslot, id: 1) }

      include_examples "tells user to login", :index
      include_examples "tells user to login", :edit, {id: 1}
      include_examples "tells user to login", :show, {id: 1}

      it 'denies user to destroy timeslots' do
        post :destroy, params: {id: timeslot.id}
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq "You need to sign in or sign up before continuing."
      end

      it "denies user to update timeslots" do
        post :update, params: {id: timeslot.id, timeslot: {description: 'test'}}
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq "You need to sign in or sign up before continuing."
      end
    end

    context "if the user is in the correct group" do
      let!(:category) { Timeslot.first || FactoryBot.create(:timeslot, id: 1) }

      before(:each) do
        login_admin
      end

      include_examples "grants access", :index
      include_examples "grants access", :edit, {id: 1}
      include_examples "grants access", :show, {id: 1}

      it 'allows admin to destroy timeslots' do
        timeslot = FactoryBot.create(:timeslot)
        post :destroy, params: {id: timeslot.id}
        expect(response.status).to eq 302
        expect(flash[:notice]).to be_present
      end

      it "allows admin to update timeslots" do
        post :update, params: {id: 1, timeslot: {description: 'test'}}
        expect(response.status).to eq 302
        expect(flash[:notice]).to be_present
      end
    end
  end

  describe "GET #index" do
    subject(:index) {get :index}

    let!(:timeslot1) {FactoryBot.create(:timeslot, description: 'timeslot 1')}
    let!(:timeslot2) {FactoryBot.create(:timeslot, description: 'timeslot 2')}

    before(:each) do
      stub_login
      index
    end

    render_views

    it 'returns a "success" status code' do
      expect(response.code).to eq('200')
    end

    it 'lists out all timeslots' do
      expect(response.body).to include(timeslot1.description)
      expect(response.body).to include(timeslot2.description)
    end
  end

  describe "GET #show" do
    subject(:show) {get :show, params: {id: timeslot.id}}

    let!(:timeslot) { FactoryBot.create(:timeslot) }

    before(:each) do
      stub_login
      show
    end

    render_views

    it 'returns a "success" status code' do
      expect(response.code).to eq('200')
    end

    it 'lists out regions' do
      expect(response.body).to include(timeslot.description)
    end
  end

  describe "GET #edit" do
    subject(:edit) {get :edit, params: {id: timeslot.id}}

    let!(:timeslot) { FactoryBot.create(:timeslot) }

    before(:each) do
      stub_login
      edit
    end

    render_views

    it 'returns a "success" status code' do
      expect(response.code).to eq('200')
    end

    it 'has the existing timeslot name' do
      expect(response.body).to include(timeslot.description)
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      subject(:update) {post :update, params: {id: timeslot.id, timeslot: {description: 'updated'}}}

      let!(:timeslot) {FactoryBot.create(:timeslot, description: 'my timeslot')}

      before(:each) do
        stub_login
        update
      end

      it 'updated the existing timeslot name' do
        timeslot.reload
        expect(timeslot.description).to eq 'updated'
      end

      it "redirects to the timeslot" do
        put :update, params: {id: timeslot.to_param, timeslot: {description: 'updated'}}
        expect(response).to redirect_to(timeslot)
      end
    end
  end

  describe "DELETE #destroy" do
    subject(:destroy) {post :destroy, params: {id: timeslot.id}}

    let!(:timeslot) {FactoryBot.create(:timeslot, description: 'delete me')}

    before(:each) do
      stub_login
      destroy
    end

    it 'updated the existing region' do
      descriptions = Timeslot.pluck(:description)
      expect(descriptions).to_not include 'delete me'
    end
  end
end
