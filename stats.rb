require 'sequel'
require 'pg'

stats_db="customer_stats"
database = Sequel.postgres(stats_db)




get '/stats' do
  @stats = database.run "SELECT customer, SUM(size / 1024 / 1024) FROM stats_all ORDER BY size DESC"
  slim :stats
end
