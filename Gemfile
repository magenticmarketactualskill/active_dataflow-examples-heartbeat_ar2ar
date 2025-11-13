source 'https://rubygems.org'

# Environment configuration for gem linking
LINK_LOCAL_GEMS = ENV.fetch('LINK_LOCAL_GEMS', 'true') == 'true'
LINK_REMOTE_GEMS = ENV.fetch('LINK_REMOTE_GEMS', 'false') == 'true'
LOCAL_GEM_ROOT = ENV.fetch('LOCAL_GEM_ROOT', '../../')

# Core ActiveDataFlow gem
if LINK_LOCAL_GEMS
  gem 'active_data_flow', path: "#{LOCAL_GEM_ROOT}core_gem/core"
elsif LINK_REMOTE_GEMS
  gem 'active_data_flow', github: 'magenticmarketactualskill/active_dataflow'
else
  gem 'active_data_flow'
end

# ActiveRecord connector for source and sink
if LINK_LOCAL_GEMS
  gem 'active_data_flow-active_record', path: "#{LOCAL_GEM_ROOT}connector_gems/active_record"
elsif LINK_REMOTE_GEMS
  gem 'active_data_flow-active_record', github: 'magenticmarketactualskill/active_dataflow'
else
  gem 'active_data_flow-active_record'
end

# Rails heartbeat app runtime
if LINK_LOCAL_GEMS
  gem 'active_data_flow-rails_heartbeat_app', path: "#{LOCAL_GEM_ROOT}runtime_gems/rails_heartbeat_app"
elsif LINK_REMOTE_GEMS
  gem 'active_data_flow-rails_heartbeat_app', github: 'magenticmarketactualskill/active_dataflow'
else
  gem 'active_data_flow-rails_heartbeat_app'
end

# Rails dependencies
gem 'rails', '~> 7.0'
gem 'sqlite3', '~> 1.4'

group :development, :test do
  gem 'rspec-rails', '~> 6.0'
  gem 'database_cleaner-active_record', '~> 2.1'
end
