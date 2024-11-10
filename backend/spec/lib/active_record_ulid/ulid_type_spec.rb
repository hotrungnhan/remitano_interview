# frozen_string_literal: true
RSpec.describe 'ActiveRecord with ulid type', type: :model do
  it 'registers ulid primary key in PostgreSQL' do
    # Create a migration with a column of type ulid
    ActiveRecord::Schema.define do
      create_table :test_ulids, id: :ulid, force: true do |t|
      end
    end
    # Check if the column is created with the expected type
    column = ActiveRecord::Base.connection.columns(:test_ulids).find { |col| col.name == 'id' }
    expect(column.type).to eq(:ulid)
    expect(column.default_function).to eq('gen_ulid()')
  end

  it 'registers ulid by columns method in PostgreSQL' do
    # Create a migration with a column of type ulid
    ActiveRecord::Schema.define do
      create_table :test_ulids, id: :ulid, force: true do |t|
        t.ulid :col_ulid
      end
    end
    # Check if the column is created with the expected type
    column = ActiveRecord::Base.connection.columns(:test_ulids).find { |col| col.name == 'col_ulid' }

    expect(column.type).to eq(:ulid)
  end
end
