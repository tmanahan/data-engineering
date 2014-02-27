# This file sources the schema definition file create.sql
# 

ActiveRecord::Schema.define(:version => 1) do

  # This loads the full database when running 'rake test'
  cmd = "mysql -uroot -ppassword  ls_test < db/create.sql"
  system cmd
  
end
