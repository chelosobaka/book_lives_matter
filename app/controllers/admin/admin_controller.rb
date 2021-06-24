class Admin::AdminController < ApplicationController
  http_basic_authenticate_with name: "login", password: "password"
  layout "admin"
end
