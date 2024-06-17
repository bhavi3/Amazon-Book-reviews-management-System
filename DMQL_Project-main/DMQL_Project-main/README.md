## DMQL_Project - Team Data Pirates - Satya Anudeep Kotaru, Bhavya Teja Inturi, Vineet Sreeram

# Follow the below steps to set up the database

Step 0: Download the 2 csv files from this link https://www.kaggle.com/datasets/mohamedbakhet/amazon-books-reviews/data and keep it in the same folder as "dataset.py" file

Step 1: Execute the "dataset.py" file to generate AmazonBooks.csv data file which serves as a base for this database.

Step 2: Create a mega table called Amazonbooks using "megaTableCreate.sql"  and load the AmazonBooks.csv file using import option in postgres.
The first step was to create a single table, AmazonBooks, to hold all the data from the CSV file. This table serves as a staging area for the entire dataset, allowing for data analysis and extraction into subsequent tables. The schema for this table includes various fields like book titles, author names, publishers, sales information, review details, and user information.

Step 3: Decompose the AmazonBooks table into smaller main tables which satisfies BCNF using "create.sql" file

Step 4: Extract data from AmazonBooks table into the 6 Main Tables using "load.sql" file
The data from the AmazonBooks table was then distributed into the corresponding main tables using INSERT statements. This process involved selecting distinct data and ensuring proper relationships among the tables. 

Step 5: Use the "index.sql" file to create indexes on tables for better query performance.

Step 6. Also, we have attached the "queries.sql" file which consists of insert, update, delete and select queries.


# Follow below steps to set up a running website to query from the website and display the results.

Step 1: Maintain the same directory format "Website"

Step 2: Install the required dependencies mentioned in the "requirements.txt" using command pip install -f requirements.txt"

Step 3: Run the app.py file with command python "app.py"

Step 4: Go to any browser and go to "http://localhost:5000/"

Step 5: Type in any query and see the results displayed (for insert, update and delete queries, the output will be a message and only for select query, tabular format data will be displayed)
