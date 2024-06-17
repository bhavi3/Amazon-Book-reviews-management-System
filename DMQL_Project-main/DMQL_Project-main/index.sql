CREATE INDEX idx_books_title ON Books(title);
CREATE INDEX idx_books_author ON Books(author);

CREATE INDEX idx_users_profile_name ON Users(profile_name);

CREATE INDEX idx_reviews_book_id ON Reviews(book_id);
CREATE INDEX idx_reviews_user_id ON Reviews(user_id);
CREATE INDEX idx_reviews_score ON Reviews(review_score);
CREATE INDEX idx_reviews_book_user ON Reviews(book_id, user_id);

CREATE INDEX idx_authors_author ON Authors(author);

CREATE INDEX idx_publishers_publisher ON Publishers(publisher);

CREATE INDEX idx_sales_category ON Sales(category);
CREATE INDEX idx_sales_top_country ON Sales(top_country);
CREATE INDEX idx_sales_language_price ON Reviews(language, price);