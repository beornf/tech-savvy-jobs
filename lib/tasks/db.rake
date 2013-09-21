namespace :db do
  desc "Drop and migrate the database"
  task :reset => ["db:migrate:reset", "db:seed", "db:test:prepare"]
end