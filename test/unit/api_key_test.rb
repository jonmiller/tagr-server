require 'test_helper'

class ApiKeyTest < ActiveSupport::TestCase
  test "create api key" do
    api_key = ApiKey.create
    assert !api_key.access_token.blank?
    Rails.logger.debug "api_key.access_token #{api_key.access_token}"
  end
end
