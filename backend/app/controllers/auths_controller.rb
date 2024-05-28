# frozen_string_literal: true

class AuthsController < ApplicationController
  before_action :set_user, only: %i[login register]
  skip_before_action :authorize_access_request!, only: %i[login register]

  # GET /auths/login
  def login
    @session = Commands::Auth::Login.new(@user, auth_params).exec
    render_one
  end

  # GET /auths/register
  def register
    @session = Commands::Auth::Register.new(@user, auth_params).exec
    render_one
  end

  # GET /auths
  def index
    render json: current_user, serializer: Serializers::User, root: :data
  end

  def render_one
    render json: @session, serializer: Serializers::Auth, root: :data
  end

  def set_user
    @user = User.find_by(email: params[:email])
  end

  def auth_params
    params.permit(:email, :password)
  end
end
