# frozen_string_literal: true

require 'rails'
require 'rails/generators'
require 'rails/generators/migration'
# = Ulid Railtie
#
# Creates a new railtie for 2 reasons:
#
# * Initialize ActiveRecord properly
# * Add hstore:setup generator
class ActiveRecordUlid < Rails::Railtie
  initializer 'active_record_ulid' do
    ActiveSupport.on_load :active_record_postgresqladapter do
      require_relative 'loader'
    end
  end

  # Creates the active_record_ulid:setup generator. This generator creates a migration that
  # adds active_record_ulid support for your database. If fact, it's just the sql from the
  # contrib inside a migration. But it' s handy, isn't it?
  #
  # To use your generator, simply run it in your project:
  #
  #   rails g active_record_ulid:setup
  class Install < Rails::Generators::Base
    include ::Rails::Generators::Migration

    def self.source_root
      @source_root ||= File.join(File.dirname(__FILE__), 'templates')
    end

    def self.next_migration_number(dirname)
      format('%.3d', (current_migration_number(dirname) + 1))
    end

    def create_migration_file
      pgversion = ::ActiveRecord::Base.connection.send(:postgresql_version)
      throw 'Your PostgreSQL version is not supported, require Postgre >= 14.0' unless pgversion > 140_000

      migration_template 'setup_ulid.rb', 'db/migrate/setup_ulid.rb'
    end
  end
end
