class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: Rails.application.credentials.dig(:auth, :username), password: Rails.application.credentials.dig(:auth, :password)
end
