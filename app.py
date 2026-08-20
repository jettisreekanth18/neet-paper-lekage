from flask import Flask, render_template, request, redirect,session
from werkzeug.security import generate_password_hash, check_password_hash
import mysql.connector

app = Flask(__name__)

app.secret_key = "neet_security_secret_key"


# ==========================================
# MYSQL DATABASE CONNECTION
# ==========================================

db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="siri@1234",
    database="neet_security"
)

cursor = db.cursor()

def log_action(username, action, paper_id=None):
    cursor = db.cursor()
    
    query = """ 
        INSERT INTO access_logs
        (username, action, paper_id)
        VALUES (%s, %s, %s)
    """
    cursor.execute(query, (username, action, paper_id))
    db.commit()


# ==========================================
# LOGIN PAGE
# ==========================================

@app.route("/")
def home():
    return render_template("login.html")


# ==========================================
# LOGIN
# ==========================================

@app.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        username = request.form["username"]
        password = request.form["password"]

        cursor = db.cursor()

        query = "SELECT username, password, role FROM users WHERE username = %s"
        cursor.execute(query, (username,))
        user = cursor.fetchone()

        if user:
            if check_password_hash(user[1], password):
                session["username"] = user[0]
                session["role"] = user[2]
                
                log_action(user[0], "Logged In")
                
                return redirect("/admin")

        return "Invalid username or password"

    return render_template("login.html")



# ==========================================
# DASHBOARD
# ==========================================

# ==========================================
# DASHBOARD
# ==========================================

@app.route("/admin")
def admin():

    if "username" not in session:
        return redirect("/login")

    if session.get("role") != "Admin":
        return "Access Denied: Admin Only", 403

    return render_template("dashboard.html")

# ==========================================
# QUESTION PAPER MANAGEMENT
# ==========================================

@app.route("/papers")
def papers():
    
    if "username" not in session:
        return redirect("/login")

    cursor.execute("SELECT * FROM papers")
    paper_list = cursor.fetchall()

    return render_template(
        "papers.html",
        papers=paper_list
    )


# ==========================================
# ADD QUESTION PAPER
# ==========================================

@app.route("/add-paper", methods=["POST"])
def add_paper():

    paper_id = request.form["paper_id"]
    paper_name = request.form["paper_name"]
    year = request.form["year"]

    # Check whether Paper ID already exists
    cursor.execute(
        "SELECT * FROM papers WHERE paper_id = %s",
        (paper_id,)
    )

    existing_paper = cursor.fetchone()

    if existing_paper:
        return "Paper ID already exists! Please use a different Paper ID."

    # Insert new paper
    query = """
        INSERT INTO papers
        (paper_id, paper_name, year, status)
        VALUES (%s, %s, %s, 'Secure')
    """

    cursor.execute(
        query,
        (paper_id, paper_name, year)
    )

    db.commit()
    
    # Record the action in Access Logs
    log_action(
        session["username"],
        "Added Question Paper",
        paper_id
    )

    return redirect("/papers")


# ==========================================
# ACCESS LOGS
# ==========================================

@app.route("/access-logs")
def access_logs():
    
    if "username" not in session:
        return redirect("/")

    cursor.execute(
        "SELECT * FROM access_logs ORDER BY access_time DESC"
    )

    logs = cursor.fetchall()

    return render_template(
        "access_logs.html",
        logs=logs
    )


# ==========================================
# LOGOUT
# ==========================================

@app.route("/logout")
def logout():
    session.clear()
    return redirect("/login")


# ==========================================
# RUN FLASK APPLICATION
# ==========================================

if __name__ == "__main__":
    app.run(debug=True)