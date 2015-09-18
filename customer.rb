require 'dm-core'
require 'dm-migrations'

# May require explicit username/password, consider defining in a YAML file
DataMapper.setup(:default, 'postgres://localhost/customer_stats')

class Customer
  include DataMapper::Resource

  property :id, Serial
  property :datestamp, Date
  property :size, Integer
  # Add more properties here
