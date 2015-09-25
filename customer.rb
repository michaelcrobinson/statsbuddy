require 'sequel'

DB = customer_stats.postgresql

class Customer do


end

DB.create_table :customers do
  primary_key: id
  Date: date
  Int: size

end
