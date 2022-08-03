#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /myapp-miguchi/tmp/pids/server.pid

# WARNING:createとseedはfargateの初回のみ実行
# WARNING:タスクを個々に作って実行の方がいいかも
bundle exec rails db:create RAILS_ENV=production
bundle exec rails db:migrate RAILS_ENV=production
bundle exec rails db:migrate:status RAILS_ENV=production
bundle exec rails db:seed RAILS_ENV=production
bundle exec rails assets:precompile RAILS_ENV=production
# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"