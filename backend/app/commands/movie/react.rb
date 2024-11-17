# frozen_string_literal: true

module Commands
  module Movie
    class React
      def initialize(performer, movie, params)
        @performer = performer
        @movie = movie
        @type = params[:type]
      end

      def exec
        @movie.increment(:up_vote) if @type == 'upvote'
        @movie.increment(:down_vote) if @type == 'downvote'
        @movie
      end
    end
  end
end
