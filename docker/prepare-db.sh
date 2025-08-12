#! /bin/sh

# If the database exists, migrate. Otherwise setup (create and migrate)
bin/rails db:prepare 2>/dev/null || bin/rails db:create db:prepare
# bundle exec rake db:drop db:create db:migrate db:seed 2>/dev/null || bundle exec rake db:drop db:create db:migrate db:seed
echo "Donee!"
