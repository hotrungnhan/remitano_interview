# frozen_string_literal: true

class ApplicationAbility
  include CanCan::Ability

  def initialize(user) # rubocop:disable Metrics/AbcSize
    # Create/ Get/ List/ Update/ Delete
    can :get, Movie, { privacy: 'public' }
    can :list, Movie, { privacy: 'public' }

    return if user.blank?

    can :create, Movie
    can :get, Movie, { privacy: 'private', uploader_id: user.id }
    can :list, Movie, { privacy: 'private', uploader_id: user.id }
    can :delete, Movie, { uploader_id: user.id }
    can :update, Movie, { uploader_id: user.id }
    can :react, Movie, { privacy: 'public' }
    can :react, Movie, { privacy: 'private', uploader_id: user.id }

    # user
    can :get_current, User
    can :delete, User, { id: user.id }
    can :update, User, { id: user.id }, %i[email role password]

    return unless user.admin?

    can :delete, Movie
    can :update, Movie, %i[title description]
    can :delete, User
    can :update, User, %i[email role password]
  end
end
