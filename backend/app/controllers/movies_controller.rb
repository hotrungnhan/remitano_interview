# frozen_string_literal: true

class MoviesController < ApplicationController
  include Concerns::Paginator
  skip_before_action :authorize_access_request!, only: %i[index]

  before_action :fetch_one, only: %i[show react]
  after_action :render_one, only: %i[show react create]

  # GET /movies
  def index
    with_validated_params!(Validations::Movies::ListParams) do |params|
      @movies = Movie.includes([:uploader]).order('created_at desc')
      render json: paginate(@movies, params),
             each_serializer: Serializers::Movie,
             meta: {
               pagination: @page_info
             }
    end
  end

  # GET /movies/:id
  def show
    render json: @movie, serializer: Serializers::Movie
  end

  # POST /movies
  def create
    with_validated_params!(Validations::Movies::CreateParams) do |params|
      @movie = Commands::Movie::Create.new(current_user, params).exec
    end
  end

  # POST /movies/:id/react
  def react
    with_validated_params!(Validations::Movies::ReactParams) do |params|
      @movie = Commands::Movie::React.new(current_user, @movie, params).exec
    end
  end

  private

    def render_one
      render json: @movie, serializer: Serializers::Movie
    end

    def fetch_one
      @movie = Movie.find(params[:id])
    end
end
