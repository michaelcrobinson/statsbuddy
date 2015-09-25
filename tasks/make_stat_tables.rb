#!/usr/bin/ruby

require 'csv'
require 'pg'
require 'sequel'

stats_path="/usr/local/src/stats/"
stats_file="customer_size.csv"
stats_db="customer_stats"
stats_date=`date +%Y%m%d`.delete!("\n") # when calling this in the pg function to_date(), must be a string
stats_tbl_current="stats_all"

database = Sequel.postgres(stats_db)

database.run "CREATE TABLE IF NOT EXISTS #{stats_tbl_current} (id serial, customer text, size bigint)"

CSV.foreach ('./sample/customer_size.csv') do |row|
  database.run "INSERT INTO #{stats_tbl_current} (customer, size) VALUES (#{row[0]}, #{row[1]})"
  customer = 'stats_' + row[0].tr('-', '_') # Replace hyphens with underscores as required by postgres for table names
                                            # Also append 'stats' at the end because postgres won't allow table names
                                            # that start with numbers
  database.run "CREATE TABLE IF NOT EXISTS #{customer} (id serial, stat_date date, size bigint)"
  database.run "INSERT INTO #{customer} (stat_date, size) VALUES ( to_date('#{stats_date}', 'YYYYMMDD'), #{row[1]})

end
