# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

namespace :tripler do
  desc "Parse an RDF file and load into the database"
  task import: :environment do
    ImportJob.perform_now(ARGV[0])
  end
end
