from flask import Flask, request, render_template
import psycopg2

app = Flask(__name__)

# Database connection parameters
DB_HOST = 'localhost'
DB_NAME = 'amazonBooksPhase2'
DB_USER = 'postgres'
DB_PASS = 'postgres'

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        user_query = request.form['query']
        headers, data, message = execute_query(user_query)
        return render_template('results.html', headers=headers, data=data, message=message)
    return render_template('index.html')

def execute_query(query):
    conn = psycopg2.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASS, host=DB_HOST)
    cur = conn.cursor()
    message = ""
    try:
        cur.execute(query)
        if query.strip().lower().startswith('select'):
            results = cur.fetchall()
            headers = [desc[0] for desc in cur.description]
        else:
            conn.commit()  
            headers = []
            results = []
            message = "Query executed successfully."
    except Exception as e:
        conn.rollback()  
        headers = []
        results = []
        message = f"Error: {e}"
    finally:
        cur.close()
        conn.close()
    return headers, results, message

if __name__ == '__main__':
    app.run(debug=True)
