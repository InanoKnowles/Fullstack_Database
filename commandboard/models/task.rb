def all_tasks
    run_sql('SELECT * FROM tasks ORDER BY id')
  end
  
  def create_task(task_name, task_instructions, assign_task_to)
    run_sql("INSERT INTO tasks(task_name, task_instructions, assign_task_to) VALUES($1, $2, $3)", [task_name, task_instructions, assign_task_to])
  end
  
  def get_task(id)
    run_sql('SELECT * FROM tasks WHERE id = $1', [id])[0]
  end
  
  def update_task(id, task_name, task_instructions, assign_task_to)
    run_sql('UPDATE tasks SET task_name = $2, task_instructions = $3, assign_task_to = $4 WHERE id = $1', [id, task_name, task_instructions, assign_task_to])
  end
  
  def delete_task(id)
    run_sql('DELETE FROM tasks WHERE id = $1', [id])
  end