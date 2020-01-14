require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'authorization' do
    context "if the user is not in the correct group" do
      let!(:user) {User.first || FactoryBot.create(:user, id: 1)}

      before(:each) do
        login_user
      end

      include_examples "denies access to user", :index
      include_examples "denies access to user", :edit, {id: 1}
      include_examples "denies access to user", :show, {id: 1}

      it 'denies user to destroy users' do
        user = FactoryBot.create(:user)
        post :destroy, params: {id: user.id}
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq "You are not authorized to perform this action."
      end

      it "denies user to update users" do
        post :update, params: {id: 1, user: {email: 'test@test.test'}}
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq "You are not authorized to perform this action."
      end
    end

    context "if the user is in the correct group" do
      let!(:user) {User.first || FactoryBot.create(:user, id: 1)}

      before(:each) do
        login_admin
      end

      include_examples "grants access", :index
      include_examples "grants access", :edit, {id: 1}
      include_examples "grants access", :show, {id: 1}

      it 'allows admin to destroy users' do
        user = FactoryBot.create(:user)
        post :destroy, params: {id: user.id}
        expect(response.status).to eq 302
        expect(flash[:notice]).to be_present
      end

      it "allows admin to update users" do
        post :update, params: {id: 1, user: {email: 'test@test.test'}}
        expect(response.status).to eq 302
        expect(flash[:notice]).to be_present
      end
    end
  end

  describe 'GET index' do
    subject(:index) {get :index}

    let!(:user1) {FactoryBot.create(:user)}
    let!(:user2) {FactoryBot.create(:user)}

    before(:each) do
      stub_login
      index
    end

    render_views

    it 'returns a "success" status code' do
      expect(response.code).to eq('200')
    end

    it 'lists out all user roles' do
      expect(response.body).to include(user1.email)
      expect(response.body).to include(user2.email)
    end
  end

  describe 'GET show' do
    subject(:show) {get :show, params: {id: user.id}}

    let!(:user) {FactoryBot.create(:user)}

    before(:each) do
      stub_login
      show
    end

    render_views

    it 'returns a "success" status code' do
      expect(response.code).to eq('200')
    end

    it 'lists out user role' do
      expect(response.body).to include(user.email)
    end
  end

  describe 'GET edit' do
    subject(:edit) {get :edit, params: {id: user.id}}

    let!(:user) {FactoryBot.create(:user)}

    before(:each) do
      stub_login
      edit
    end

    render_views

    it 'returns a "success" status code' do
      expect(response.code).to eq('200')
    end

    it 'has the existing role name' do
      expect(response.body).to include(user.email)
    end
  end

  describe 'POST update' do
    subject(:update) {post :update, params: {id: user.id, user: {written: true}}}

    let!(:user) {FactoryBot.create(:user)}

    before(:each) do
      stub_login
      update
    end

    it 'updated the existing role name' do
      user.reload
      expect(user.first_time).to eq true
    end
  end

  describe 'POST delete' do
    subject(:destroy) {post :destroy, params: {id: user.id}}

    let!(:user) {FactoryBot.create(:user, email: 'delete@deleted.gone')}

    before(:each) do
      stub_login
      destroy
    end

    it 'updated the existing role name' do
      emails = User.pluck(:email)
      expect(emails).to_not include 'delete@deleted.gone'
    end
  end
end
