get '/' do
  tasks = all_tasks()

  erb :'tasks/index', locals: {
    tasks: tasks
  }
end

get '/tasks/new' do

  if !logged_in?
    redirect '/'
  end

  all_users = find_all_users()

   erb :'tasks/new', locals: {
    all_users: all_users
  }
end

post '/tasks' do

  if !logged_in?
    redirect '/'
  end

  task_name = params['task_name']
  task_instructions = params['task_instructions']
  assign_task_to = params['assign_task_to']

  create_task(task_name, task_instructions, assign_task_to)
  redirect '/'
end

get '/tasks/:id/edit' do

  if !logged_in?
    redirect '/'
  end

  id = params['id']
 
  task = find_assignee()

  erb :'tasks/edit', locals: {
    task: task
  }
end

put '/tasks/:id' do

  if !logged_in?
    redirect '/'
  end

  id = params['id']
  task_name = params['task_name']
  task_instructions = params['task_instructions']
  assign_task_to = params['assign_task_to']


  update_task(id, task_name, task_instructions, assign_task_to)
  redirect '/'
end

delete '/tasks/:id' do

  if !logged_in?
    redirect '/'
  end

  id = params['id']

  delete_task(id)
  redirect '/'
end

post '/tasks/:id/done' do
  task_id = params['id']
  user_id = session['user_id']

  run_sql("INSERT INTO done(user_id, task_id) VALUES($1, $2)", [user_id, task_id])
  redirect '/'
end