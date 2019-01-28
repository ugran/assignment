require 'activerecord'
require_relative './db_models'

#seed users
20.times do 
    User.create(
        name: Faker::Name.name 
    )
end


#seed authors
50.times do
    Author.create(
        name: Faker::Book.unique.author
    )
end

#seed genres
20.times do
    Genre.create(
        name: Faker::Book.unique.genre
    )
end

#seed books
500.times do 
    number_of_genres = rand(Genre.count)
    list_of_genres = []
    number_of_genres.times do
        genre = Genre.order("RANDOM()").first
        unless list_of_genres.includes? genre.id
            list_of_genres.push(genre.id)
        end
    end
    author_id = Author.order("RANDOM()").first
    Book.create(
        title: Faker::Book.unique.title,
        published_on: Faker::Date.birthday(1, 650),
        author_id: author_id,
        genre_list: list_of_genres.to_s
    )
end

#seed upvotes
1000.times do
    user = User.order("RANDOM()").first.id
    book = Book.order("RANDOM()").first.id
    upvote = Upvote.find_by(user_id: user, book_id: book)
    unless upvote.present?
        Upvote.create(
            user_id: User.order("RANDOM()").first,
            book_id: Book.order("RANDOM()").first
        )
    end
end

#seed follows
100.times do
    user = User.order("RANDOM()").first.id
    author = Author.order("RANDOM()").first.id
    follow = Follow.find_by(user_id: user, author_id: book)
    unless follow.present?
        Follow.create(
            user_id: User.order("RANDOM()").first,
            author_id: Book.order("RANDOM()").first
        )
    end
end