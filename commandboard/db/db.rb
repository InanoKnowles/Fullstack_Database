require 'pg'

def run_sql(sql, sql_params = [])
  db = PG.connect(dbname: 'command_board_db')
  results = db.exec_params(sql, sql_params)
  db.close
  results
end