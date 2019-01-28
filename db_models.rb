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
require 'json'

class User < ActiveRecord::Base
    has_many :upvotes
    has_many :books, through: :upvotes
    has_many :follows
    has_many :authors, through: :follows
end

class Author < ActiveRecord::Base
    has_many :users, through: :follows
end

class Book < ActiveRecord::Base
    has_many :upvotes
    has_many :users, through: :upvotes

    def genres
        list = JSON.parse(self.genre_list)
        return Genre.where("id = ?", list)
    end
end

class Upvote < ActiveRecord::Base
    belongs_to :user
    belongs_to :book

    validates :user, uniqueness: { scope: :book }
end

class Follow < ActiveRecord::Base
    belongs_to :user
    belongs_to :author

    validates :user, uniqueness: { scope: :author }
end

class Genre < ActiveRecord::Base
end