The project is using Sqlite3 and because of that genres for books are saved as array converted to string and then retrieved with JSON.parse.

One has to run DB creating script in the for_starting_the_project folder to create db and then seed DB with faker script.

DB models are kept in a single file for doing it fast and easy.

Feed retrieveing is done with constructing arrays from 3 different arrays:
1. upvoted books
2. followed author books
3. other books

Logically it should not matter when the book was published (actual publishing of the book), the date that matters is when the book was added to the DB.
So the base ordering is done with Ids` and not the published_on column.

For feed refresh method one has to pass already retrieved book collection to the method and as new books can't be upvoted yet, refresh doesn't include logic for upvotes.

In the feedWithGenres the feed implements a method to check for user taste - which calculates the taste of a user according to his/her upvotes.

After calculating the priorities for a user for each genre, the sorting is done with book ratings for the specific user, which is calculated according to the priorities of the user.

This way, the sorting may actually take a lot of time as the database grows, and for this we may create a background job that will save (in DB) priorities ( updated in case of a new upvote) & ratings for each user for every new book.
