require 'sinatra'
require 'pg'

def run_sql(sql, sql_params = [])
  db = PG.connect(dbname: 'command_board_db')
  results = db.exec_params(sql, sql_params)
  db.close
  results
end

get '/' do
  tasks = run_sql('SELECT * FROM tasks')

  erb :'tasks/index', locals: {
    tasks: tasks
  }
end

get '/tasks/new' do
  # We ONLY use erb files if its a GET request.
  erb :'tasks/new'
end

post '/tasks' do
  task_name = params['task_name']
  task_instructions = params['task_instructions']
  assign_task_to = params['assign_task_to']

  run_sql("INSERT INTO tasks(task_name, task_instructions, assign_task_to) VALUES($1, $2, $3)", [task_name, task_instructions, assign_task_to])

  # We ALWAYS redirect the user at the end of a POST, PUT or DELETE method.
  redirect '/'
end