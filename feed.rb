require 'active_record'
require_relative 'db_models'

class Feed
    def initialize(user)
      @user = User.find(user.id)
    end
  
    def retrieve
      upvoted = @user.books
      followed_author_books = Book.where(id: @user.authors.map(&:id)) - upvoted
      books = [ *upvoted,*followed_author_books]
      other_books = Book.all - books
      return [ *books, *other_books]
    end

    def refresh(already_retrieved)
      followed_author_new_books = Book.where(id: @user.authors.map(&:id)) - already_retrieved
      other_books = Book.all - followed_author_new_books - already_retrieved
      return [*followed_author_new_books, *other_books]
    end
end
