# rubocop:disable Gemspec/DevelopmentDependencies
# frozen_string_literal: true

require_relative 'active_record_ulid/loader'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = 'active_record_ulid'
  s.version = '0.1.0'

  s.platform    = Gem::Platform::RUBY
  s.license     = 'MIT'
  s.authors     = ['Ho Trung Nhan']
  s.email       = 'hotrungnhan29@gmail.com'
  s.homepage    = 'http://github.com/hotrungnhan/active-record-ulid'
  s.summary     = 'Goodbye uuid, hello ulid'
  s.description = ''
  s.required_ruby_version     = '>= 3.2.0'
  s.required_rubygems_version = '>= 3.5.0'

  s.add_dependency 'activerecord', '>= 7.1'
  s.add_dependency 'activesupport', '>= 7.1'
  s.add_dependency 'ulid'
  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rdoc'
  s.add_development_dependency 'rspec', '>= 3.0'

  git_files = begin
    `git ls-files`.split("\n")
  rescue StandardError
    ''
  end
  s.files              = git_files
  s.executables        = []
  s.require_paths      = %w[active_record_ulid]
  s.metadata['rubygems_mfa_required'] = 'true'
end
# rubocop:enable Gemspec/DevelopmentDependencies
