class ApplicationController < ActionController::Base
  before_action :authenticate

  private

  def authenticate
    return if cookies.signed[:authenticated]

    authenticate_or_request_with_http_basic do |username, password|
      authenticated = ActiveSupport::SecurityUtils.secure_compare(username, Rails.application.credentials.dig(:auth, :username)) &&
                      ActiveSupport::SecurityUtils.secure_compare(password, Rails.application.credentials.dig(:auth, :password))

      cookies.signed[:authenticated] = { value: true, expires: 1.month.from_now } if authenticated

      authenticated
    end
  end
end
