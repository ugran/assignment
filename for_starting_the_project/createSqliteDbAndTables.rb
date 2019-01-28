# User
#   - name

# Author
#   - name

# Book
#   - author
#   - title
#   - published_on

# Upvote
#   - user
#   - book

# Follow
#   - user
#   - author

require "sqlite3"

db = SQLite3::Database.new "./test.db"

db.execute <<-SQL
  create table users (
    id integer primary key autoincrement,
    name text
  ); 
SQL

db.execute <<-SQL
  create table authors (
    id integer primary key autoincrement,
    name text
  );
SQL

db.execute <<-SQL
  create table books (
    id integer primary key autoincrement,
    title text,
    published_on text,
    author_id int,
    genre_list text
  );
SQL

db.execute <<-SQL
  create table upvotes (
    id integer primary key autoincrement,
    user_id int,
    book_id int
  );
SQL

db.execute <<-SQL
  create table follows (
    id integer primary key autoincrement,
    user_id int,
    author_id int
  );
SQL

db.execute <<-SQL
  create table genres (
    id integer primary key autoincrement,
    name text
  );
SQL