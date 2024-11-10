# rubocop:disable Gemspec/DevelopmentDependencies
# frozen_string_literal: true

require_relative 'json_hash/json_hash'

Gem::Specification.new do |s|
  s.name = 'json_hash'
  s.version = '0.1.0'

  s.platform    = Gem::Platform::RUBY
  s.license     = 'MIT'
  s.authors     = ['Ho Trung Nhan']
  s.email       = 'hotrungnhan29@gmail.com'
  s.homepage    = 'http://github.com/hotrungnhan/ruby_json_hash'
  s.summary     = 'Goodbye uuid, hello ulid'
  s.description = ''
  s.required_ruby_version     = '>= 3.2.0'
  s.required_rubygems_version = '>= 3.5.0'

  s.add_runtime_dependency 'oj'
  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rdoc'
  s.add_development_dependency 'rspec', '>= 3.0'

  s.files              =['json_hash/json_hash']
  s.executables        = []
  s.require_paths      = %w[json_hash]
  s.metadata['rubygems_mfa_required'] = 'true'
end


# rubocop:enable Gemspec/DevelopmentDependencies
