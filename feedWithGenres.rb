require 'active_record'
require_relative 'db_models'

class Feed
    def initialize(user)
        @user = User.find(user.id)
    end
  
    def retrieve
        user_taste = self.user_taste
        upvoted = @user.books
        followed_author_books = Book.where(id: @user.authors.map(&:id)) - upvoted
        books = [ *sort_with_ratings(user_taste, upvoted),*sort_with_ratings(user_taste,followed_author_books)]
        other_books = Book.all - books
        return [ *books, *sort_with_ratings(user_taste,other_books)]
    end

    def refresh(already_retrieved)
        user_taste = self.user_taste
        followed_author_new_books = Book.where(id: @user.authors.map(&:id)) - already_retrieved
        other_books = Book.all - followed_author_new_books - already_retrieved
        return [*sort_with_ratings(user_taste, followed_author_new_books), *sort_with_ratings(user_taste,other_books)]
    end

    private

    def user_taste
        priorities = {}
        Genre.all.each do |g|
            priorities[g.id] = 0
        end
        priorities[sum] = 0
        @user.books.each do |b|
            book_genres = eval(b.genre_list)
            book_genres.each do |g|
                priorities[g] += 1
                priorities[sum] += 1
            end
        end
        return priorities
    end

    def sort_with_ratings(user_taste,books)
        with_ratings = []
        books.each do |b|
            rating = 0
            book_genres = eval(b.genre_list)
            book_genres.each do |g|
                #here sums should be made with BigDecimals
                if user_taste[g] != 0
                    rating += user_taste[g]/user_taste[sum]
                end
            end
            with_ratings.push({ book: b, rating: rating })
        end
        sorted = with_ratings.sort_by { |b| b[:rating] }
        return sorted.map { |b| b.book}
    end
end

