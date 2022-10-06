#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
# rm -f /myapp-miguchi/tmp/pids/server.pid

# DBコンテナが起動するまで待つ記述
until mysqladmin ping -h $DB_HOST -u root --silent; do
  echo "waiting for mysql..."
  sleep 3s
done
echo "success to connect mysql"

# DB起動関連
bundle exec rails db:create 
bundle exec rails db:migrate 
bundle exec rails db:migrate:status
bundle exec rails db:seed 
# 本番環境のみ実行したい
bundle exec rails assets:precompile RAILS_ENV=production

# railsアプリ起動コマンド
bundle exec unicorn -p 3000 -c /myapp-miguchi/config/unicorn.rb
# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"