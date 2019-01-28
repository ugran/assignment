require 'active_record'
require_relative 'db_models'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'test.db')

Author.create(name: 'irakli')
puts Author.first.name