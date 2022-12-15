require 'dotenv/load'
require 'sinatra'
require 'bcrypt'
require './db/db'
require 'httparty'

# this makes the session hash work
enable :sessions

# models
require './models/task'
require './models/user'

# controllers
require './controllers/tasks_controller'
require './controllers/users_controller'
require './controllers/sessions_controller'

# helpers
require './helpers/sessions_helper'