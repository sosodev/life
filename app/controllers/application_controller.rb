class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: ENV["LIFE_USERNAME"], password: ENV["LIFE_PASSWORD"]
end
