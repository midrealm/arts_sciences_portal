require 'rails_helper'

RSpec.describe JudgeAssignsController, type: :controller do
  describe 'authorization' do
    context "if the user is not in the correct group" do
      let!(:judge_assign) {JudgeAssign.first || FactoryBot.create(:judge_assign, id: 1)}

      before(:each) do
        login_user
      end

      include_examples "denies access to user", :index
      include_examples "denies access to user", :edit, {id: 1}
      include_examples "denies access to user", :show, {id: 1}
      include_examples "denies access to user", :destroy, {id: 1}
      include_examples "denies access to user", :new

      it "denies user to create user roles" do
        post :create, params: {id: judge_assign.id, judge_assign: {shadow: true}}
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq "You are not authorized to perform this action."

      end

      it "denies user to update user roles" do
        post :update, params: {id: judge_assign.id, judge_assign: {shadow: true}}
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq "You are not authorized to perform this action."
      end
    end

    context "if the user is in the correct group" do
      let!(:judge_assign) {JudgeAssign.first || FactoryBot.create(:judge_assign, id: 1)}

      before(:each) do
        login_admin
      end

      include_examples "grants access", :index
      include_examples "grants access", :edit, {id: 1}
      include_examples "grants access", :show, {id: 1}
      include_examples "grants access", :new

      it 'allows admin to destroy judge assignments' do
        judge_assign = FactoryBot.create(:judge_assign)
        post :destroy, params: {id: judge_assign.id}
        expect(response.status).to eq 302
        expect(flash[:notice]).to be_present
      end

      it "allows admin to create judge assignments" do
        user = FactoryBot.create(:user)
        entry = FactoryBot.create(:entry)
        timeslot = FactoryBot.create(:timeslot)

        post :create, params: {id: judge_assign.id, judge_assign: {user_id: user.id, entry_id: entry.id, timeslot_id: timeslot.id}}
        expect(response.status).to eq 302
        expect(flash[:notice]).to be_present
      end

      it "allows admin to update judge assignments" do
        post :update, params: {id: judge_assign.id, judge_assign: {shadow: true}}
        expect(response.status).to eq 302
        expect(flash[:notice]).to be_present
      end
    end
  end

  describe 'GET index' do
    subject(:index) {get :index}

    let!(:user1) {FactoryBot.create(:user, email: 'user1@email.com')}
    let!(:user2) {FactoryBot.create(:user, email: 'user2@email.com')}
    let!(:judge_assign1) {FactoryBot.create(:judge_assign, user: user1)}
    let!(:judge_assign2) {FactoryBot.create(:judge_assign, user: user2)}

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
    subject(:show) {get :show, params: {id: judge_assign.id}}

    let!(:user) {FactoryBot.create(:user)}
    let!(:entry) {FactoryBot.create(:entry)}
    let!(:judge_assign) {FactoryBot.create(:judge_assign, user: user, entry: entry)}

    before(:each) do
      stub_login
      show
    end

    render_views

    it 'returns a "success" status code' do
      expect(response.code).to eq('200')
    end

    it 'lists out judges' do
      expect(response.body).to include(judge_assign.user.email)
    end
  end

  describe 'GET edit' do
    subject(:edit) {get :edit, params: {id: judge_assign.id}}

    let!(:judge_assign) {FactoryBot.create(:judge_assign)}

    before(:each) do
      stub_login
      edit
    end

    render_views

    it 'returns a "success" status code' do
      expect(response.code).to eq('200')
    end

    it 'has the existing judge name' do
      expect(response.body).to include(judge_assign.user.email)
    end
  end

  describe 'POST update' do
    subject(:update) {post :update, params: {id: judge_assign.id, judge_assign: {user_id: new_user.id}}}

    let!(:new_user) {FactoryBot.create(:user, email: 'updated@email.com')}
    let!(:judge_assign) {FactoryBot.create(:judge_assign)}

    before(:each) do
      stub_login
      update
    end

    it 'updated the existing judge' do
      judge_assign.reload
      expect(judge_assign.user.email).to eq 'updated@email.com'
    end
  end

  describe 'POST delete' do
    subject(:destroy) {post :destroy, params: {id: judge_assign.id}}

    let!(:user) {FactoryBot.create(:user, email: 'deleteme@email.com')}
    let!(:judge_assign) {FactoryBot.create(:judge_assign, user: user)}

    before(:each) do
      stub_login
      destroy
    end

    it 'deleted the judge assign' do
      judges = JudgeAssign.all
      judges.each do |judge|
        expect(judge.user.email).to_not be 'deleteme@email.com'
      end
    end
  end
end
