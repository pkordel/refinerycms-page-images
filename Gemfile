source 'http://rubygems.org'

gemspec

gem 'refinerycms', git: 'https://github.com/refinery/refinerycms'
gem 'refinerycms-i18n', git: 'https://github.com/refinery/refinerycms-i18n'
gem 'refinerycms-wymeditor', '~> 1.0.0'

gem 'mime-types', '~> 1.25'

group :test do
  gem 'refinerycms-testing', git: 'https://github.com/refinery/refinerycms'
  gem 'poltergeist'
end

# Database Configuration
unless ENV['TRAVIS']
  gem 'activerecord-jdbcsqlite3-adapter', platform: :jruby
  group :development, :test do
    gem 'sqlite3', platform: :ruby
  end
end

if !ENV['TRAVIS'] || ENV['DB'] == 'mysql'
  gem 'activerecord-jdbcmysql-adapter', platform: :jruby
  gem 'jdbc-mysql', '= 5.1.13', platform: :jruby
  gem 'mysql2', platform: :ruby
end

if !ENV['TRAVIS'] || ENV['DB'] == 'postgresql'
  gem 'activerecord-jdbcpostgresql-adapter', platform: :jruby
  gem 'pg', platform: :ruby
end

# Refinery/rails should pull in the proper versions of these
gem 'sass-rails', '~> 4.0.0'
gem 'coffee-rails', '~> 4.0.0'

# Load local gems according to Refinery developer preference.
if File.exist? local_gemfile = File.expand_path('../.gemfile', __FILE__)
  eval File.read(local_gemfile)
end
