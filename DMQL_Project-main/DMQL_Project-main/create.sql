CREATE TABLE Books(
	book_id SERIAL,
	title TEXT,
	author VARCHAR(50),
	category VARCHAR(255),
	primary key(book_id)
);

CREATE TABLE Users(
	user_id VARCHAR(25) NOT NULL,
	profile_name VARCHAR(50),
	user_email VARCHAR(50),
	primary key(user_id)
);

CREATE TABLE Reviews(
	review_id SERIAL,
	book_id INT,
	user_id VARCHAR(25),
	ratings_count INT,
	review_helpfulness VARCHAR(10),
	review_score INT,
	review_time VARCHAR(20),
	review_summary VARCHAR(255),
	primary key(review_id),
	foreign key(book_id) references Books(book_id) on delete cascade, 
	foreign key(user_id) references Users(user_id) on delete cascade
);

CREATE TABLE Authors(
	author_id SERIAL,
	author VARCHAR(100),
	author_email VARCHAR(100),
	book_id INT,
	primary key(author_id),
	foreign key(book_id) references Books(book_id) on delete set null
);

CREATE TABLE Publishers(
	publisher_id SERIAL,
	publisher VARCHAR(150),
	published_year INT,
	book_id INT,
	primary key(publisher_id),
	foreign key(book_id) references Books(book_id) on delete cascade
);

CREATE TABLE Sales(
	sale_id SERIAL,
	category VARCHAR(255),
	top_country VARCHAR(255),
	books_sold INT,
	price INT,
	language VARCHAR(15),
	publisher_id INT,
	primary key(sale_id),
	foreign key(publisher_id) references Publishers(publisher_id) on delete set null
);