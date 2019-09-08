require 'rails_helper'
include ActionDispatch::Integration::RequestHelpers

describe UserRolesController, type: :controller do
  describe 'authorization' do
    context "if the user is not in the correct group" do
      before(:each) do
        login_user
      end

      include_examples "denies access to user", :index
      include_examples "denies access to user", :edit, {id: 1}
      include_examples "denies access to user", :show, {id: 1}
      include_examples "denies access to user", :destroy, {id: 1}
      include_examples "denies access to user", :new

      it "denies user to create user roles" do
        post :create, params: {id: 1, user_role: {role_name: 'test'}}
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq "You are not authorized to perform this action."

      end

      it "denies user to update user roles" do
        post :update, params: {id: 1, user_role: {role_name: 'test'}}
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq "You are not authorized to perform this action."
      end
    end

    context "if the user is in the correct group" do
      before(:each) do
        login_admin
      end

      include_examples "grants access", :index
      include_examples "grants access", :edit, {id: 1}
      include_examples "grants access", :show, {id: 1}
      include_examples "grants access", :new

      it 'allows admin to destroy user roles' do
        user_role = FactoryBot.create(:user_role)
        post :destroy, params: {id: user_role.id}
        expect(response.status).to eq 302
        expect(flash[:notice]).to be_present
      end

      it "allows admin to create user roles" do
        post :create, params: {id: 1, user_role: {role_name: 'test'}}
        expect(response.status).to eq 302
        expect(flash[:notice]).to be_present
      end

      it "allows admin to update user roles" do
        post :update, params: {id: 1, user_role: {role_name: 'test'}}
        expect(response.status).to eq 302
        expect(flash[:notice]).to be_present
      end
    end
  end

  describe 'GET index' do
    subject(:index) {get :index}

    let!(:user_role1) {FactoryBot.create(:user_role, role_name: 'my role')}
    let!(:user_role2) {FactoryBot.create(:user_role, role_name: 'my role')}

    before(:each) do
      stub_login
      index
    end

    render_views

    it 'returns a "success" status code' do
      expect(response.code).to eq('200')
    end

    it 'lists out all user roles' do
      expect(response.body).to include(user_role1.role_name)
      expect(response.body).to include(user_role2.role_name)
    end
  end

  describe 'GET show' do
    subject(:show) {get :show, params: {id: user_role.id}}

    let!(:user_role) {FactoryBot.create(:user_role, role_name: 'my role')}

    before(:each) do
      stub_login
      show
    end

    render_views

    it 'returns a "success" status code' do
      expect(response.code).to eq('200')
    end

    it 'lists out user role' do
      expect(response.body).to include(user_role.role_name)
    end
  end

  describe 'GET edit' do
    subject(:edit) {get :edit, params: {id: user_role.id}}

    let!(:user_role) {FactoryBot.create(:user_role, role_name: 'my role')}

    before(:each) do
      stub_login
      edit
    end

    render_views

    it 'returns a "success" status code' do
      expect(response.code).to eq('200')
    end

    it 'has the existing role name' do
      expect(response.body).to include(user_role.role_name)
    end
  end

  describe 'POST update' do
    subject(:update) {post :update, params: {id: user_role.id, user_role: {role_name: 'updated'}}}

    let!(:user_role) {FactoryBot.create(:user_role, role_name: 'my role')}

    before(:each) do
      stub_login
      update
    end

    it 'updated the existing role name' do
      user_role.reload
      expect(user_role.role_name).to eq 'updated'
    end
  end

  describe 'POST delete' do
    subject(:destroy) {post :destroy, params: {id: user_role.id}}

    let!(:user_role) {FactoryBot.create(:user_role, role_name: 'delete me')}

    before(:each) do
      stub_login
      destroy
    end

    it 'updated the existing role name' do
      names = UserRole.pluck(:role_name)
      expect(names).to_not include 'delete me'
    end
  end
end
