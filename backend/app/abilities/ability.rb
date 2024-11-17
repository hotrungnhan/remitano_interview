# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Movie, { privacy: 'public' }
    can :reaction, Movie, { privacy: 'public' }

    return if user.blank?

    can :create, Movie
    can :read, Movie, { privacy: 'private', uploader_id: user.id }
    can :delete, Movie, { uploader_id: user.id }
    can :update, Movie, { uploader_id: user.id }, %i[title description]

    return if user.role.admin?

    can :delete, Movie
    can :update, Movie, %i[title description]
  end
end
