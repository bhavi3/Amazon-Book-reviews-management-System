---- INSERT QUERIES ----
-- Inserting a new book with the same author as an existing book:
INSERT INTO books (title, author, category)
VALUES (
    'New Adventure Land',
    (SELECT author FROM books WHERE title = 'The Great Gatsby'),
    'Adventure'
);

-- Inserting a new review with a specific user and book, calculated rating count:
INSERT INTO reviews (book_id, user_id, ratings_count, review_helpfulness, review_score, review_time, review_summary)
VALUES (
    698,
    (SELECT user_id FROM users WHERE profile_name = 'Theresa Jennifer'),
    (SELECT COUNT(*) + 1 FROM reviews WHERE book_id = 698),
    '3/4',
    3,
    1214784000,
    'Great dystopian novel!'
);

---- DELETE QUERIES ----
-- Deleting reviews for a book with a low average review score:
DELETE FROM reviews
WHERE book_id = 1455
AND review_score < (
    SELECT AVG(review_score) FROM reviews WHERE book_id = 1455
);

-- Deleting sales records for a specific category if the total sales are below average:
DELETE FROM sales
WHERE category = ' activities' 
AND books_sold < (
    SELECT AVG(s.books_sold)
    FROM sales s
    WHERE s.category = ' activities'
);


---- UPDATE QUERIES ----
-- Updating the book category to 'Classic' for all books published before 1980 by Penguin publisher:
UPDATE books
SET category = 'Classic'
WHERE title IN (
    SELECT b.title
    FROM books b
    JOIN publishers p ON b.book_id = p.book_id
    WHERE p.publisher = 'Penguin' AND p.published_year < 1980
);

-- Updating the review score for a specific book based on the average review score across all reviews:
UPDATE reviews
SET review_score = (
    SELECT AVG(review_score)
    FROM reviews
)
WHERE book_id = (
    SELECT book_id
    FROM books
    WHERE title = 'Born On A Rotten Day'
);

---- SELECT QUERIES ----
-- Selecting all reviews for a specific book, ordered by review_score in descending order:
SELECT r.book_id, u.profile_name, r.review_score, r.review_summary
FROM reviews r
JOIN users u ON r.user_id = u.user_id
WHERE r.book_id = 71844
ORDER BY r.review_score DESC;

-- Finding the top-selling book in a given category:
SELECT s.category, s.top_country, s.books_sold, b.title
FROM sales s
JOIN books b ON s.category = b.category
WHERE s.category = 'graphic novels'
ORDER BY s.books_sold DESC
LIMIT 1;

-- Counting the number of books by each author, grouped by author:
SELECT a.author, COUNT(b.title) AS book_count
FROM authors a
JOIN books b ON a.author = b.author
GROUP BY a.author
ORDER BY book_count DESC;

-- Finding the top 3 publishers with the most books published in the last 5 years:
SELECT p.publisher, COUNT(b.title) AS books_published
FROM publishers p
JOIN books b ON p.book_id = b.book_id
WHERE p.published_year between 2015 and 2023
GROUP BY p.publisher
ORDER BY books_published DESC
LIMIT 3;

-- Selecting the books with reviews that have an average score greater than 4, using a subquery:
SELECT b.title, AVG(r.review_score) AS average_score
FROM books b
JOIN reviews r ON b.book_id = r.book_id
GROUP BY b.title
HAVING AVG(r.review_score) > 4
ORDER BY average_score DESC;


-- Finding the book with the highest review score along with its author and the user who gave the review:
SELECT b.title, a.author, u.profile_name, r.review_score
FROM books b
JOIN reviews r ON b.book_id = r.book_id
JOIN authors a ON b.author = a.author
JOIN users u ON r.user_id = u.user_id
WHERE r.review_score = (
  SELECT MAX(review_score)
  FROM reviews
)
ORDER BY review_score DESC;


-- Selecting pulishers who have published at least 10 books and listing their average sales in descending order:
SELECT distinct p.publisher, AVG(s.books_sold) AS average_sales
FROM publishers p
JOIN sales s ON p.publisher_id = s.publisher_id
WHERE p.publisher IN (
  SELECT publisher
  FROM publishers
  GROUP BY publisher
  HAVING COUNT(publisher) >= 10
)
GROUP BY p.publisher
ORDER BY average_sales DESC;


-- Selecting distinct books whose reviews have a score above average review score:
SELECT distinct b.title, p.publisher, r.review_score
FROM books b
JOIN reviews r ON b.book_id = r.book_id
JOIN publishers p ON b.book_id = p.book_id
WHERE r.review_score > (
SELECT AVG(review_score)
FROM reviews
)
ORDER BY r.review_score DESC;


-- Selecting Book Categories with Average Review Scores and Users Over 10 Reviewers
SELECT B.category, AVG(R.review_score) AS average_score, COUNT(R.review_id) AS total_reviews, COUNT(DISTINCT R.user_id) AS distinct_users
FROM Books B
JOIN Reviews R ON B.book_id = R.book_id
JOIN Users U ON R.user_id = U.user_id
GROUP BY B.category
HAVING COUNT(DISTINCT R.user_id) > 10
ORDER BY average_score DESC;
