require 'rails_helper'

RSpec.describe JudgePreferencesController, type: :controller do
  describe 'authorization' do
    context "if the preferences don't belong to the user" do
      let!(:judge_preference) {FactoryBot.create(:judge_preference, id: 1, user_id: right_user.id)}
      let!(:category) {FactoryBot.create(:category)}
      let!(:right_user) {FactoryBot.create(:user)}
      let!(:wrong_user) {FactoryBot.create(:user)}

      before(:each) do
        login_existing_user wrong_user
      end

      it "denies user to view the preferences" do
        get :index, params: {user_id: right_user.id}
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq "You are not authorized to perform this action."
      end

      it "denies user to destroy the preference" do
        post :destroy, params: {user_id: right_user.id, id: judge_preference.id}
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq "You are not authorized to perform this action."
      end

      it "denies user to create a new preference" do
        get :new, params: {user_id: right_user.id}
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq "You are not authorized to perform this action."
      end

      it "denies user to create jude preferences" do
        post :create, params: {id: judge_preference.id, user_id: right_user.id, judge_preference: {judge_preferences: {category_id: category.id}}}
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq "You are not authorized to perform this action."
      end
    end

    context "if the preferences belong to the user" do
      let!(:judge_preference) {FactoryBot.create(:judge_preference, id: 1, user_id: right_user.id)}
      let!(:category) {FactoryBot.create(:category)}
      let!(:right_user) {FactoryBot.create(:user)}

      before(:each) do
        login_existing_user right_user
      end

      it "allows user to view the preferences" do
        get :index, params: {user_id: right_user.id}
        expect(response.status).to eq 200
      end

      it "allows user to destroy the preference" do
        post :destroy, params: {user_id: right_user.id, id: judge_preference.id}
        expect(response.status).to eq 302
        expect(flash[:notice]).to be_present
      end

      it "allows user to create a new preference" do
        get :new, params: {user_id: right_user.id}
        expect(response.status).to eq 200
      end

      it "allows user to create preferences" do
        post :create, params: {id: judge_preference.id, user_id: right_user.id, judge_preference: {judge_preferences: {category_id: category.id}}}
        expect(response.status).to eq 302
        expect(flash[:notice]).to be_present
      end
    end

    context "if the user is in the correct group" do
      let!(:judge_preference) {FactoryBot.create(:judge_preference, id: 1, user_id: user.id)}
      let!(:user) {FactoryBot.create(:user)}

      before(:each) do
        login_admin
      end

      it "allows admin to view a users index" do
        get :index, params: {user_id: user.id}
        expect(response.status).to eq 200
      end

      it "allows admin to create a new preference" do
        get :new, params: {user_id: user.id}
        expect(response.status).to eq 200
      end

      it 'allows admin to destroy judge preferences' do
        judge_preference = FactoryBot.create(:judge_preference)
        post :destroy, params: {id: judge_preference.id, user_id: user.id}
        expect(response.status).to eq 302
        expect(flash[:notice]).to be_present
      end

      it "allows admin to create judge preferences" do
        user = FactoryBot.create(:user)
        category = FactoryBot.create(:category)

        post :create, params: {id: judge_preference.id, user_id: user.id, judge_preference: {judge_preferences: {category_id: category.id}}}
        expect(response.status).to eq 302
        expect(flash[:notice]).to be_present
      end
    end
  end

  describe 'GET index' do
    subject(:index) {get :index, params: {user_id: user.id}}

    let!(:user) {FactoryBot.create(:user)}
    let!(:category1) {FactoryBot.create(:category, name: 'category 1')}
    let!(:category2) {FactoryBot.create(:category, name: 'category 2')}
    let!(:judge_preference1) {FactoryBot.create(:judge_preference, category_id: category1.id, user_id: user.id)}
    let!(:judge_preference2) {FactoryBot.create(:judge_preference, category_id: category2.id, user_id: user.id)}

    before(:each) do
      stub_login
      index
    end

    render_views

    it 'returns a "success" status code' do
      expect(response.code).to eq('200')
    end

    it 'lists out all judge preferences' do
      puts judge_preference1.inspect
      expect(response.body).to include(category1.name)
      expect(response.body).to include(category2.name)
    end
  end

  describe 'POST delete' do
    subject(:destroy) {post :destroy, params: {user_id: user.id, id: judge_preference.id}}

    let!(:category) {FactoryBot.create(:category, name: 'delete me')}
    let!(:user) {FactoryBot.create(:user)}
    let!(:judge_preference) {FactoryBot.create(:judge_preference, category: category, user: user)}

    before(:each) do
      stub_login
      destroy
    end

    it 'deleted the judge assign' do
      preferences = JudgePreference.all
      preferences.each do |judge|
        expect(preferences.category.name).to_not be 'delete me'
      end
    end
  end
end
