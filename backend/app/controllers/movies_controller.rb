# frozen_string_literal: true

class MoviesController < ApplicationController
  include Concerns::Paginator
  skip_before_action :authorize_access_request!, only: %i[index]

  before_action :fetch_one, only: %i[show react destroy]
  after_action :render_one, only: %i[show react]

  # GET /movies
  def index
    authorize! :list, Movie

    validated_params = validate_params!(Validations::Movies::ListParams)

    movies = Movie.accessible_by(current_ability, :list).includes([:uploader])
    filtered_movies = ::Filters::Movie.new(validated_params, movies).exec
    filtered_sorted_movies = ::Sorters::Movie.new(validated_params, filtered_movies).exec
    paginated_filtered_sorted_movies = paginate(filtered_sorted_movies, validated_params)

    render json: paginated_filtered_sorted_movies,
           each_serializer: Serializers::Movie,
           meta: {
             pagination: @page_info
           }
  end

  # GET /movies/:id
  def show
    render json: @movie, serializer: Serializers::Movie
  end

  # POST /movies
  def create
    authorize! :create, Movie
    with_validated_params!(Validations::Movies::CreateParams) do |params|
      @movie = Commands::Movie::Create.new(current_user, params).exec
    end
    render json: @movie, serializer: Serializers::Movie, status: :created
  end

  # DELETE /movies/:id
  def destroy
    authorize! :delete, @movie
    @movie.destroy!

    head :accepted
  end

  # POST /movies/:id/react
  def react
    authorize! :react, @movie
    with_validated_params!(Validations::Movies::ReactParams) do |params|
      @movie = Commands::Movie::React.new(current_user, @movie, params).exec
    end
  end

  private

    def render_one
      render json: @movie, serializer: Serializers::Movie
    end

    def fetch_one
      authorize! :get, Movie
      @movie = Movie.accessible_by(current_ability, :get).find(params[:id])
    end
end
