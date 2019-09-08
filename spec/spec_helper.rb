require 'rspec/junklet'
require 'factory_bot_rails'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|

    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  FactoryBot::SyntaxRunner.send(:include, RSpec::Junklet::Junk)
end

def login_admin
  @request.env["devise.mapping"] = Devise.mappings[:admin]
  sign_in FactoryBot.create(:user, :admin)
end

def login_user
  @request.env["devise.mapping"] = Devise.mappings[:user]
  sign_in FactoryBot.create(:user)
end

def stub_login
  user = FactoryBot.create(:user, :admin)
  allow(request.env['warden']).to receive(:authenticate!).and_return(user)
  allow(controller).to receive(:current_user).and_return(user)
end
