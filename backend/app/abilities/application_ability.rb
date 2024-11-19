# frozen_string_literal: true

class ApplicationAbility
  include CanCan::Ability
  OWNER_KEYS = %i[uploader_id owner_id].freeze

  def initialize(user) # rubocop:disable Metrics/AbcSize
    # Create/ Get/ List/ Update/ Delete
    return if user.blank?

    can :get_current, User

    can :get, Movie, { privacy: 'public' }
    can :list, Movie, { privacy: 'public' }

    return unless user.normal? || user.admin?

    can :create, Movie
    can :get, Movie, { privacy: 'private', uploader_id: user.id }
    can :list, Movie, { privacy: 'private', uploader_id: user.id }
    can :delete, Movie, { uploader_id: user.id }
    can :update, Movie, { uploader_id: user.id }
    can :react, Movie, { privacy: 'public' }
    can :react, Movie, { privacy: 'private', uploader_id: user.id }
    # user
    can :delete, User, { id: user.id }
    can :update, User, { id: user.id }, %i[email role password]

    return unless user.admin?

    can :delete, Movie
    can :update, Movie, %i[title description]
    can :delete, User
    can :update, User, %i[email role password]
  end

  def to_a
    rules.map do |rule|
      action = rule.actions.join(', ') # Combine multiple actions into a string
      subject = rule.subjects.map { |s| s.is_a?(Class) ? s.name : s }.join(', ') # Handle class names or symbols
      negation = rule.base_behavior ? 'can' : 'cannot'
      on_own = rule.conditions.keys.any? { |key| OWNER_KEYS.include?(key) } ? '_its_own' : ''
      "#{negation}_#{action.downcase}#{on_own}_#{subject.downcase}"
    end.uniq
  end
end
