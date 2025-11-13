source 'https://rubygems.org'

# Core ActiveDataFlow gem
gem 'active_data_flow', path: '../../core_gem/core'

# ActiveRecord connector for source and sink
gem 'active_data_flow-active_record', path: '../../connector_gems/active_record'

# Rails heartbeat app runtime
gem 'active_data_flow-rails_heartbeat_app', path: '../../runtime_gems/rails_heartbeat_app'

# Rails dependencies
gem 'rails', '~> 7.0'
gem 'sqlite3', '~> 1.4'

group :development, :test do
  gem 'rspec-rails', '~> 6.0'
  gem 'database_cleaner-active_record', '~> 2.1'
end
