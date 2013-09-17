#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

ENV['SKIP_RAILS_ADMIN_INITIALIZER']='true'
ENV['WITHOUT_PROTECTION']='false'

require File.expand_path('../config/application', __FILE__)

Jobs::Application.load_tasks
