insert into books (title, author, category)
select distinct title, author, category from amazonbooks;

insert into users (user_id, profile_name, user_email)
select distinct user_id, profile_name, user_email from amazonbooks;

insert into reviews (book_id, user_id, ratings_count, review_helpfulness, review_score, review_time, review_summary)
select distinct b.book_id, u.user_id, ab.ratings_count, ab.review_helpfulness, ab.review_score, ab.review_time, ab.review_summary
from AmazonBooks ab
join Books b on ab.title = b.title -- Assuming title uniquely identifies books
join Users u on ab.user_id = u.user_id; -- Assuming user_id in AmazonBooks matches with Users

insert into authors (author, author_email, book_id)
select distinct a.author, a.author_email, b.book_id from amazonbooks a join books b on a.author = b.author ;

insert into publishers (publisher, published_year, book_id)
select distinct a.publisher, a.published_year, b.book_id from amazonbooks a join books b on a.title = b.title ;

insert into sales (category, top_country, books_sold, price, language, publisher_id)
select distinct a.category, a.top_country, a.books_sold, a.price, a.language, p.publisher_id
from amazonbooks a
join publishers p on a.publisher = p.publisher and a.published_year = p.published_year
where exists ( select 1 from books b where b.book_id = p.book_id and b.title = a.title );


-- WHERE Clause: Ensures that there is a corresponding book_id in the Books table that matches the book_id 
-- in the Publishers table and the title in the AmazonBooks table. This step is crucial to verify that the 
-- data being inserted corresponds to actual books registered in the system.