# frozen_string_literal: true

require 'active_record'
require 'active_record/connection_adapters/postgresql_adapter'
require 'active_support'
require_relative 'oid/ulid'
require_relative 'schema_defination'
require_relative 'adapters'
require_relative 'quoting'
require_relative 'railties'

ActiveRecord::ConnectionAdapters::PostgreSQLAdapter::NATIVE_DATABASE_TYPES[:ulid] = { name: 'ulid' }

ActiveSupport.on_load(:active_record_postgresqladapter) do
  ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.prepend(ActiveRecordULID::Adapters) # rubocop:disable Rails/ActiveSupportOnLoad
  ActiveRecord::ConnectionAdapters::PostgreSQL::TableDefinition.include(ActiveRecordULID::ColumnMethods)
  ActiveRecord::ConnectionAdapters::PostgreSQL::Quoting.prepend(ActiveRecordULID::Quoting)
end
1
