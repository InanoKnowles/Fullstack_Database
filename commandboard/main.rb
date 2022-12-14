require 'sinatra'
require 'pg'

def run_sql(sql, sql_params = [])
  db = PG.connect(dbname: 'command_board_db')
  results = db.exec_params(sql, sql_params)
  db.close
  results
end

get '/' do
  tasks = run_sql('SELECT * FROM tasks ORDER BY id')

  erb :'tasks/index', locals: {
    tasks: tasks
  }
end

get '/tasks/new' do
  erb :'tasks/new'
end

post '/tasks' do
  task_name = params['task_name']
  task_instructions = params['task_instructions']
  assign_task_to = params['assign_task_to']

  run_sql("INSERT INTO tasks(task_name, task_instructions, assign_task_to) VALUES($1, $2, $3)", [task_name, task_instructions, assign_task_to])
  redirect '/'
end

get '/tasks/:id/edit' do
  id = params['id']
  task = run_sql('SELECT * FROM tasks WHERE id = $1', [id])[0]

  erb :'tasks/edit', locals: {
    task: task
  }
end

put '/tasks/:id' do
  id = params['id']
  task_name = params['task_name']
  task_instructions = params['task_instructions']
  assign_task_to = params['assign_task_to']

  run_sql('UPDATE tasks SET task_name =$2, task_instructions =$3, assign_task_to = $4 WHERE id = $1', [id, task_name, task_instructions, assign_task_to])
  redirect '/'
end

delete '/tasks/:id' do
  id = params['id']
  run_sql('DELETE FROM tasks WHERE id = $1', [id])
  redirect '/'
end

get '/users/new' do
  erb :'users/new'
end

post '/users' do
  first_name = params['first_name']
  last_name = params['last_name']
  email = params['email']
  run_sql("INSERT INTO users(first_name, last_name, email) VALUES($1, $2, $3)", [first_name, last_name, email])
  redirect '/'
end