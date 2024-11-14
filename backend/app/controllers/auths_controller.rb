# frozen_string_literal: true

class AuthsController < ApplicationController
  before_action :set_user, only: %i[login register]
  skip_before_action :authorize_access_request!, only: %i[login register]

  # POST /auths/login
  def login
    validated_params = validate_params!(Validations::Auths::Login)
    @session = Commands::Auth::Login.new(@user, validated_params).exec
    render_one
  end

  # POST /auths/register
  def register
    validated_params = validate_params!(Validations::Auths::SignUp)
    @session = Commands::Auth::Register.new(@user, validated_params).exec

    render json: @session, serializer: Serializers::Auth
  end

  # GET /auths
  def index
    render json: current_user, serializer: Serializers::User
  end

  def render_one
    render json: {
      access_token: @session[:access]
    }
  end

  def set_user
    @user = User.find_by(email: params[:email])
  end
end
