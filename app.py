from flask import Flask, render_template, request, redirect, url_for, session, flash
import os, uuid, json
import random
from flask import jsonify
from werkzeug.security import generate_password_hash, check_password_hash
from werkzeug.utils import secure_filename
from functools import wraps
from flask import make_response
import mysql.connector
from urllib.parse import urlparse

app = Flask(__name__)
app.secret_key = "enterprise_secret_key"

UPLOAD_FOLDER = 'static/uploads'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER




# ---------------- DATABASE ----------------
#db = mysql.connector.connect(
  #  host="127.0.0.1",              # Use 127.0.0.1 instead of localhost
  #  user="root",
  #  password="",                    # leave empty if no password
    #database="assessment_system",
    #port=3307                       # Must match your MySQL config
#)

#cursor = db.cursor(dictionary=True, buffered=True)

import os
import mysql.connector
from urllib.parse import urlparse

# ---------------- DATABASE ----------------
url = os.getenv("DB_URL")

result = urlparse(url)

db = mysql.connector.connect(
    host=result.hostname,
    user=result.username,
    password=result.password,
    database=result.path[1:],
    port=result.port
)

cursor = db.cursor(dictionary=True, buffered=True)

# ---------------- CONFIG ----------------
UPLOAD_FOLDER = "static/uploads/photos"
ALLOWED_EXTENSIONS = {"png", "jpg", "jpeg"}
os.makedirs(UPLOAD_FOLDER, exist_ok=True)

def allowed_file(filename):
    return "." in filename and filename.rsplit(".", 1)[1].lower() in ALLOWED_EXTENSIONS

# =========================================================
# DISABLE CACHE FOR ALL PAGES AFTER LOGIN
# Prevent browser from showing old pages after logout
# =========================================================
@app.after_request
def add_header(response):
    response.headers["Cache-Control"] = "no-store, no-cache, must-revalidate, max-age=0"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "0"
    return response


# =========================================================

# =========================================================
# REGISTER
# =========================================================
@app.route("/", methods=["GET", "POST"])
def register():
    if request.method == "POST":
        email = request.form["email"].lower()
        roll_no = request.form["roll_no"]

        if not roll_no.isdigit():
            flash("Code must be a number")
            return redirect(url_for("register"))

        roll_no = int(roll_no)
        if roll_no < 100 or roll_no > 110:
            flash("Code must be between 100 and 110")
            return redirect(url_for("register"))

        cursor.execute("SELECT * FROM studentss WHERE email=%s", (email,))
        if cursor.fetchone():
            flash("Email already registered")
            return redirect(url_for("register"))

        cursor.execute("SELECT * FROM studentss WHERE roll_no=%s", (roll_no,))
        if cursor.fetchone():
            flash("Code already used")
            return redirect(url_for("register"))

        photo = request.files["photo"]
        if photo.filename == "" or not allowed_file(photo.filename):
            flash("Upload JPG or PNG photo")
            return redirect(url_for("register"))

        filename = str(uuid.uuid4()) + "_" + secure_filename(photo.filename)
        photo.save(os.path.join(UPLOAD_FOLDER, filename))

        password_hash = generate_password_hash(request.form["password"])

        query = """
        INSERT INTO studentss
        (name, email, password, course, school, semester, roll_no, photo, assessment_status, score)
        VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)
        """
        values = (
            request.form["name"],
            email,
            password_hash,
            request.form["course"],
            request.form["school"],
            request.form["semester"],
            roll_no,
            filename,
            "NOT_STARTED",
            0
            
        )

        cursor.execute(query, values)
        db.commit()
        flash("Registration successful")
        return redirect(url_for("login"))

    return render_template("register.html")

# =========================================================
# LOGIN
# =========================================================
@app.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        email = request.form["email"].lower()
        password = request.form["password"]

        # Get user from database
        cursor.execute("SELECT * FROM studentss WHERE email=%s", (email,))
        user = cursor.fetchone()

        # Check password
        if user and check_password_hash(user["password"], password):
            session["email"] = email  # Save login session
            flash("Login successful!", "success")  # Optional flash message
            return redirect(url_for("dashboard"))  # Go to dashboard
        else:
            flash("Invalid email or password!", "danger")  # Show error

    return render_template("login.html")
# =======================================================================
#Forgot pass word
# ======================================================================
from datetime import datetime, timedelta
import secrets

@app.route("/forgot", methods=["GET", "POST"])
def forgot_password():
    if request.method == "POST":
        email = request.form["email"].lower()
        cursor.execute("SELECT * FROM studentss WHERE email=%s", (email,))
        user = cursor.fetchone()

        if user:
            # Generate a secure token
            token = secrets.token_urlsafe(16)
            expiry = datetime.now() + timedelta(hours=1)  # token valid for 1 hour

            # Save token and expiry in database
            cursor.execute("""
                UPDATE studentss
                SET reset_token=%s, reset_token_expiry=%s
                WHERE email=%s
            """, (token, expiry, email))
            db.commit()

            reset_link = url_for("reset_password", token=token, _external=True)
            flash(f"Password reset link (simulate sending email): {reset_link}", "info")
        else:
            flash("Email not found", "danger")
        return redirect(url_for("forgot_password"))

    return render_template("forgot.html")

@app.route("/reset/<token>", methods=["GET", "POST"])
def reset_password(token):
    cursor.execute("SELECT * FROM studentss WHERE reset_token=%s", (token,))
    user = cursor.fetchone()

    if not user:
        flash("Invalid or expired token", "danger")
        return redirect(url_for("login"))

    # Check expiry
    if datetime.now() > user["reset_token_expiry"]:
        flash("Token expired", "danger")
        return redirect(url_for("forgot_password"))

    if request.method == "POST":
        new_password = request.form["password"]
        password_hash = generate_password_hash(new_password)

        # Update password and clear token
        cursor.execute("""
            UPDATE studentss
            SET password=%s, reset_token=NULL, reset_token_expiry=NULL
            WHERE id=%s
        """, (password_hash, user["id"]))
        db.commit()

        flash("Password reset successful. You can now login.", "success")
        return redirect(url_for("login"))

    return render_template("reset.html")




#========================================================================




# =========================================================
# DASHBOARD
# =========================================================
@app.route("/dashboard")
def dashboard():
    if "email" not in session:
        return redirect(url_for("login"))

    # Get logged-in student info
    cursor.execute("SELECT * FROM studentss WHERE email=%s", (session["email"],))
    user = cursor.fetchone()

    # Get all active assessments for the student's course
    cursor.execute("""
        SELECT * FROM assessment
        WHERE status='active' AND subject=%s
    """, (user['course'],))
    assessments = cursor.fetchall()

    return render_template("dashboard.html", user=user, assessments=assessments)
# =========================================================
# ASSESSMENT
# =========================================================
@app.route("/assessment/<int:assessment_id>", methods=["GET", "POST"])
def assessment(assessment_id):

    if "email" not in session:
        return redirect(url_for("login"))

    # GET assessment
    cursor.execute(
        "SELECT * FROM assessment WHERE id=%s AND status='active'",
        (assessment_id,)
    )
    assessment_data = cursor.fetchone()

    if not assessment_data:
        return "Assessment not found", 404

    # CHECK COMPLETED
    cursor.execute("""
        SELECT * FROM exam_attempts
        WHERE student_email=%s AND assessment_id=%s AND status='completed'
    """, (session["email"], assessment_id))

    completed_attempt = cursor.fetchone()

    if completed_attempt:
        flash("You already completed this assessment!")
        session["attempt_id"] = completed_attempt["id"]
        return redirect(url_for("result"))

    # CHECK IN PROGRESS
    cursor.execute("""
        SELECT * FROM exam_attempts
        WHERE student_email=%s AND assessment_id=%s AND status='in_progress'
    """, (session["email"], assessment_id))

    attempt = cursor.fetchone()

    # LOAD QUESTIONS FUNCTION
    def load_random_questions(file_path, count):
        if not file_path or int(count) <= 0:
            return []

        full_path = os.path.join(app.root_path, "static", "uploads", file_path)

        if not os.path.exists(full_path):
            print("❌ File not found:", full_path)
            return []

        try:
            with open(full_path, "r") as f:
                data = json.load(f)

                if not isinstance(data, list):
                    print("❌ JSON not list")
                    return []

                return random.sample(data, min(int(count), len(data)))

        except Exception as e:
            print("❌ JSON ERROR:", e)
            return []

    # RESUME OR GENERATE
    if attempt:
        questions = json.loads(attempt["questions"] or "[]")

        # FIX: delete bad attempt
        if not questions:
            cursor.execute("DELETE FROM exam_attempts WHERE id=%s", (attempt["id"],))
            db.commit()
            attempt = None
        else:
            session["attempt_id"] = attempt["id"]

    if not attempt:
        questions = []

        questions += load_random_questions(assessment_data['easy_file'], assessment_data['easy'])
        questions += load_random_questions(assessment_data['medium_file'], assessment_data['medium'])
        questions += load_random_questions(assessment_data['hard_file'], assessment_data['hard'])

        random.shuffle(questions)

        for i, q in enumerate(questions):
            q["id"] = f"q{i+1}"

            if "options" in q:
                q["option1"], q["option2"], q["option3"], q["option4"] = q["options"]

            q["correct_answer"] = q.get("answer")

        if not questions:
            return "❌ No questions loaded. Check JSON files."

        cursor.execute("""
            INSERT INTO exam_attempts (student_email, assessment_id, questions, status)
            VALUES (%s, %s, %s, 'in_progress')
        """, (session["email"], assessment_id, json.dumps(questions)))

        db.commit()
        session["attempt_id"] = cursor.lastrowid

    # SUBMIT
    if request.method == "POST":

        answers = request.form.to_dict()

        cursor.execute(
            "SELECT questions FROM exam_attempts WHERE id=%s",
            (session["attempt_id"],)
        )
        data = cursor.fetchone()

        questions = json.loads(data["questions"] or "[]")

        score = 0
        for q in questions:
            if answers.get(q["id"]) == q["correct_answer"]:
                score += 1
        # Calculate total from DB
        cursor.execute("SELECT total FROM assessment WHERE id=%s", (assessment_id,))
        assessment_info = cursor.fetchone()

        total = assessment_info["total"] if assessment_info else len(questions)

        percentage = (score / total) * 100

# PASS / FAIL
        result_status = "PASSED" if percentage >= 35 else "FAILED"

        cursor.execute("""
        UPDATE exam_attempts
         SET answers=%s, score=%s, status='completed', result_status=%s
         WHERE id=%s
        """, (json.dumps(answers), score, result_status, session["attempt_id"]))

        db.commit()

        return redirect(url_for("result"))

    return render_template("assessment.html", questions=questions, assessment=assessment_data)
# =========================================================
# RESULT
# =========================================================
@app.route("/result")
def result():
    if "email" not in session or "attempt_id" not in session:
        return redirect(url_for("login"))

    cursor.execute("""
        SELECT questions, answers, score
        FROM exam_attempts
        WHERE id=%s
    """, (session["attempt_id"],))

    data = cursor.fetchone()

    if not data:
        return "No result found"

    #  Safe JSON loading
    questions = json.loads(data["questions"] or "[]")

    if data["answers"]:
        answers = json.loads(data["answers"])
    else:
        answers = {}

    score = data["score"] or 0

    total = len(questions)
    answered = len([a for a in answers.values() if a])
    unanswered = total - answered
    wrong = answered - score

    detailed_results = []

    for q in questions:
        user_answer = answers.get(q["id"])
        detailed_results.append({
            "question": q["question"],
            "user_answer": user_answer,
            "correct_answer": q["correct_answer"],
            "is_correct": user_answer == q["correct_answer"]
        })

    return render_template(
        "result.html",
        score=score,
        total=total,
        answered=answered,
        unanswered=unanswered,
        wrong=wrong,
        detailed_results=detailed_results
    )
    
# =========================================================
# PROFILE
# =========================================================
@app.route("/profile")
def profile():
    if "email" not in session:
        return redirect(url_for("login"))

    cursor.execute("SELECT * FROM studentss WHERE email=%s", (session["email"],))
    user = cursor.fetchone()
    return render_template("profile.html", user=user)

# =========================================================

@app.route("/galary")
def galary():
    if "email" not in session:
        return redirect(url_for("login"))

    cursor.execute("""
        SELECT a.subject, e.score, a.total, e.id AS attempt_id
        FROM exam_attempts e
        JOIN assessment a ON e.assessment_id = a.id
        WHERE e.student_email = %s
        AND e.status = 'completed'
        AND e.result_status = 'PASSED'
    """, (session["email"],))

    certificates = cursor.fetchall()

    return render_template("galary.html", certificates=certificates)














@app.route("/certificate/<int:attempt_id>")
def certificate_by_id(attempt_id):
    if "email" not in session:
        return redirect(url_for("login"))

    cursor.execute("""
        SELECT e.score, a.total, s.name, s.course
        FROM exam_attempts e
        JOIN assessment a ON e.assessment_id = a.id
        JOIN studentss s ON e.student_email = s.email
        WHERE e.id=%s AND e.student_email=%s
    """, (attempt_id, session["email"]))

    data = cursor.fetchone()

    if not data:
        return "Unauthorized"

    percentage = (data["score"] / data["total"]) * 100

    if percentage < 35:
        return "Not eligible"

    date = datetime.now().strftime("%d %B %Y")

    return render_template(
        "certificate.html",
        name=data["name"],
        course=data["course"],
        score=data["score"],
        total=data["total"],
        percentage=round(percentage, 2),
        date=date
    )
# =============================================================
#Performance
# ============================================================

@app.route("/performance")
def performance():
    if "email" not in session:
        return redirect(url_for("login"))

    return render_template("performance.html")


#===========================================================
#API/Performane
#============================================================
@app.route("/api/performance")
def performance_api():
    if "email" not in session:
        return jsonify({"error": "unauthorized"})

    cursor.execute("""
        SELECT a.id, a.subject, e.score, a.total
        FROM exam_attempts e
        JOIN assessment a ON e.assessment_id = a.id
        WHERE e.student_email = %s AND e.status = 'completed'
    """, (session["email"],))

    rows = cursor.fetchall()

    labels = []
    scores = []
    percentages = []
    assessment_ids = []   

    for i, row in enumerate(rows, start=1):
        labels.append(f"Test {i} ({row['subject']})")  
        scores.append(row["score"])
        assessment_ids.append(row["id"])   

        total = row["total"] if row["total"] else 1
        percent = (row["score"] / total) * 100
        percentages.append(round(percent, 2))

    return jsonify({
        "labels": labels,
        "scores": scores,
        "percentages": percentages,
        "assessment_ids": assessment_ids   
    })

#===================================================
#leaderboard
#====================================================
@app.route("/api/leaderboard/<int:assessment_id>")
def leaderboard_api(assessment_id):
    if "email" not in session:
        return jsonify({"error": "unauthorized"})

    cursor.execute("""
        SELECT s.name, e.score
        FROM exam_attempts e
        JOIN studentss s ON e.student_email = s.email
        WHERE e.assessment_id = %s AND e.status='completed'
        ORDER BY e.score DESC
    """, (assessment_id,))

    rows = cursor.fetchall()

    leaderboard = []
    rank = 1

    for r in rows:
        leaderboard.append({
            "rank": rank,
            "name": r["name"],
            "score": r["score"]
        })
        rank += 1

    return jsonify(leaderboard)
#===============================================

# ===================================================
# LOGOUT
# =========================================================
@app.route("/logout")
def logout():
    session.clear()
    return redirect(url_for("login"))
# =====================================================
#admin part
#====================================================
#local host
#===================================================
#++++++++++++++++++++++++++++++++++++++++++++++++++++++
#admin Login
#+++++++++++++++++++++++++++++++++++++++++++++++++++
@app.route("/admin", methods=["GET","POST"])
def admin_login():
    if request.method == "POST":
        if request.form["username"] == "admin" and request.form["password"] == "admin123":
            session["admin"] = True
            return redirect("/admin/dashboard")
    return render_template("admin_login.html")
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#admin dashboard
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
@app.route("/admin/dashboard")
def admin_dashboard():
    if "admin" not in session:
        return redirect("/admin")
    return render_template("admin.html")
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++



#CreateAssessment
#+++++++++++++++++++++++++++++++++++++++++++++++++++++

@app.route("/admin/create_assessment", methods=["POST"])
def create_assessment():
    if "admin" not in session:
        return {"error": "unauthorized"}
   

    subject = request.form['subject']
    duration = request.form['duration']
    total = request.form['total']
    easy = request.form['easy_count']
    medium = request.form['medium_count']
    hard = request.form['hard_count']

    # Files
    easy_file = request.files['easy']
    medium_file = request.files['medium']
    hard_file = request.files['hard']

    # Save files
    easy_filename = os.path.join(app.config['UPLOAD_FOLDER'], easy_file.filename)
    medium_filename = os.path.join(app.config['UPLOAD_FOLDER'], medium_file.filename)
    hard_filename = os.path.join(app.config['UPLOAD_FOLDER'], hard_file.filename)

    easy_file.save(easy_filename)
    medium_file.save(medium_filename)
    hard_file.save(hard_filename)

    # Insert into database
    sql = """
        INSERT INTO assessment
        (subject, duration, total, easy, medium, hard, easy_file, medium_file, hard_file)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
    """
    values = (subject, duration, total, easy, medium, hard, easy_file.filename, medium_file.filename, hard_file.filename)
    cursor.execute(sql, values)
    db.commit()

    return jsonify({"status": "success", "message": "Assessment created successfully"})
    


#++++++++++++++++++++++++++++++++++++++++++++++++++++++
#View Assessment
#+++++++++++++++++++++++++++++++++++++++++++++++++++++
@app.route("/admin/assessments")
def get_assessments():
    if "admin" not in session:
        return {"error": "unauthorized"}

    cursor.execute("SELECT * FROM assessment where status='active'")
    return jsonify(cursor.fetchall())

#+++++++++++++++++++++++++++++++++++++++++++++++++++++

#Detelete Assessment
#+++++++++++++++++++++++++++++++++++++++++++++++++++
@app.route("/admin/delete/<int:id>", methods=["DELETE"])
def delete_assessment(id):
    if "admin" not in session:
        return {"error": "unauthorized"}

    cursor.execute("UPDATE assessment  SET status='deleted' WHERE id=%s", (id,))
    db.commit()

    return jsonify({"message": "deleted"})


#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#Addd Quetion
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
@app.route("/admin/add_question", methods=["POST"])
def add_question():
    if "admin" not in session:
        return {"error": "unauthorized"}

    data = request.json

    cursor.execute("""
        INSERT INTO questions
        (assessment_id, question, option1, option2, option3, option4, correct_answer, difficulty)
        VALUES (%s,%s,%s,%s,%s,%s,%s,%s)
    """, (
        data["assessment_id"],
        data["question"],
        data["option1"],
        data["option2"],
        data["option3"],
        data["option4"],
        data["correct_answer"],
        data["difficulty"]
    ))

    db.commit()
    return {"message": "question added"}

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++




#+++++++++++++++++++++++++++++++++++++++++++++++++++++
# Admin History (ALL assessments)
#+++++++++++++++++++++++++++++++++++++++++++++++++++++
@app.route("/admin/history")
def admin_history():
    if "admin" not in session:
        return {"error": "unauthorized"}

    cursor.execute("""
        SELECT id, subject, duration, total, easy, medium, hard, status
        FROM assessment
        ORDER BY id DESC
    """)

    return jsonify(cursor.fetchall())
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#++++++++++++++++++++++++++++++++++++++++++++++++++++++
# ADMIN LOGOUT
#++++++++++++++++++++++++++++++++++++++++++++++++++++++
@app.route("/admin/logout")
def admin_logout():
    session.clear() 
    return redirect("/admin")
#+++++++++++++++++++++++++++++++++++++++++++++++++++++

#certificate
#++++++++++++++++++++++++++++++++++++++++++++++++++++

from datetime import datetime   

@app.route("/certificate")
def certificate():
    if "email" not in session or "attempt_id" not in session:
        return redirect(url_for("login"))

    cursor.execute("""
        SELECT e.score, a.total, s.name, s.course
        FROM exam_attempts e
        JOIN assessment a ON e.assessment_id = a.id
        JOIN studentss s ON e.student_email = s.email
        WHERE e.id=%s
    """, (session["attempt_id"],))

    data = cursor.fetchone()

    if not data:
        return "No certificate data found"

    score = data["score"]
    total = data["total"]
    percentage = (score / total) * 100

    if percentage < 35:
        flash("Certificate available only if score is above 35%")
        return redirect(url_for("result"))

    # ✅ FIX: Generate date here
    current_date = datetime.now().strftime("%d %B %Y")

    return render_template(
        "certificate.html",
        name=data["name"],
        course=data["course"],
        score=score,
        total=total,
        percentage=round(percentage, 2),
        date=current_date   
    )
#++++++++++++++++++++++++++++++++++++++++++++++++++++++
#performance
#++++++++++++++++++++++++++++++++++++++++++++++++++++
@app.route("/admin/performance_page")
def admin_performance_page():
    if "admin" not in session:
        return redirect("/admin")
    return render_template("admin_performance.html")



#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#performance API
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# ============================================
# ADMIN FILTER API (SUBJECT + TEST FILTER FIX)
# ============================================
@app.route("/admin/api/performance")
def admin_performance_filter():
    if "admin" not in session:
        return jsonify({"error": "unauthorized"})

    subject = request.args.get("subject", "").strip()
    assessment_id = request.args.get("assessment_id", "").strip()
    score_filter = request.args.get("score_filter", "").strip()

    query = """
        SELECT 
            a.id,
            a.subject,
            a.total,
            s.name,
            s.email,
            e.score
        FROM exam_attempts e
        JOIN assessment a ON e.assessment_id = a.id
        JOIN studentss s ON e.student_email = s.email
        WHERE e.status = 'completed'
    """

    params = []

    if subject:
        query += " AND a.subject = %s"
        params.append(subject)

    if assessment_id:
        query += " AND a.id = %s"
        params.append(assessment_id)

    query += " ORDER BY e.score DESC"

    cursor.execute(query, tuple(params))
    rows = cursor.fetchall()

    results = []

    for row in rows:
        total = row["total"] if row["total"] else 1
        percentage = round((row["score"] / total) * 100, 2)

        if score_filter == "top" and percentage < 80:
            continue

        if score_filter == "fail" and percentage >= 40:
            continue

        results.append({
            "id": row["id"],
            "subject": row["subject"],
            "name": row["name"],
            "email": row["email"],
            "score": percentage
        })

    return jsonify(results)
# ============================================
# ADMIN FILTER DROPDOWN API
# ============================================

#++++++++++++++++++++++++++++++++++++++++++++++++++++
#filter API
#+++++++++++++++++++++++++++++++++++++++++++++++++++++
# REPLACE your /admin/api/performance route with this FULL corrected version

@app.route("/admin/api/filters")
def admin_filters():
    if "admin" not in session:
        return jsonify({"error": "unauthorized"})

    # Get all active subjects
    cursor.execute("""
        SELECT DISTINCT subject
        FROM assessment
        WHERE status='active'
    """)
    subjects = [row["subject"] for row in cursor.fetchall()]

    # Get all active tests
    cursor.execute("""
        SELECT id, subject
        FROM assessment
        WHERE status='active'
        ORDER BY id DESC
    """)
    tests = cursor.fetchall()

    return jsonify({
        "subjects": subjects,
        "tests": tests
    })

#+++++++++++++++++++++++++++++++++++++++++++++++++++
















# =========================================================
# RUN APP
# =========================================================
if __name__ == "__main__":
    app.run(debug=True)
