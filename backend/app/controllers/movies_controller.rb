# frozen_string_literal: true

class MoviesController < ApplicationController
  include Concerns::Paginator
  skip_before_action :authorize_access_request!, only: %i[index]
  # GET /movies
  def index
    with_validated_params!(Validations::Movies::ListParams) do |params|
      @movies = Movie.includes([:uploader]).order('created_at desc').all

      render json: paginate(@movies, params),
             each_serializer: Serializers::Movie,
             meta: {
               pagination: @page_info
             }
    end
  end

  # POST /movies
  def create
    with_validated_params!(Validations::Movies::CreateParams) do |params|
      @movie = Commands::Movie::Create.new(current_user, params).exec
      render json: @movie, serializer: Serializers::Movie
    end
  end
end
