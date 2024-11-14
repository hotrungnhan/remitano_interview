Dry::Schema.load_extensions(:json_schema, :hints)

class Dry::Schema::Macros::DSL
  def default(value)
    schema_dsl.before(:rule_applier) do |result|
      result.update(name => value) if result.output && !result[name]
    end
  end
end
