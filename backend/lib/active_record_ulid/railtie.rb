# frozen_string_literal: true

require 'rails'
require 'rails/generators'
require 'rails/generators/migration'
require 'active_record'
require 'active_record/connection_adapters/postgresql_adapter'
require 'active_support'
require_relative 'oid/ulid'
require_relative 'schema_defination'
require_relative 'adapters'
require_relative 'quoting'

# = Ulid Railtie
#
# Creates a new railtie for 2 reasons:
#
# * Initialize ActiveRecord properly
# * Add active_record_ulid:install generator
class ActiveRecordUlid < Rails::Railtie
  initializer 'active_record_ulid' do
    ActiveRecord::ConnectionAdapters::PostgreSQLAdapter::NATIVE_DATABASE_TYPES[:ulid] = { name: 'ulid' }

    ActiveSupport.on_load(:active_record_postgresqladapter) do
      prepend ActiveRecordULID::Adapters
      prepend ActiveRecordULID::Quoting
    end
    ActiveRecord::ConnectionAdapters::PostgreSQL::TableDefinition.include(ActiveRecordULID::ColumnMethods)
  end

  # Creates the active_record_ulid:install generator. This generator creates a migration that
  # adds active_record_ulid support for your database. If fact, it's just the sql from the
  # contrib inside a migration. But it' s handy, isn't it?
  #
  # To use your generator, simply run it in your project:
  #
  #   rails g active_record_ulid:install
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

      Rails.logger.info! <<~TER
        You're all set!
        Add this changes to "#{Rails.root}/config/application.rb"
        ```
        class Application < Rails::Application\e[32m
          config.active_record.primary_key = :ulid
          config.generators do |g|
            g.orm :active_record, primary_key_type: :ulid
            g.orm :active_record, foreign_key_type: :ulid
          end\e[0m
        end
        ```
      TER
    end
  end
end
