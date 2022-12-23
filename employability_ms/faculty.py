from flask import Blueprint, render_template, request, flash, redirect, url_for, jsonify, make_response, session
from flask_login import login_required, current_user
from .models import *
from werkzeug.security import generate_password_hash, check_password_hash
from flask_login import login_user, login_required, logout_user, current_user
from sqlalchemy import delete
from sqlalchemy import select
import json

from .auth import send_link, send_link_disapproved # for email message

_faculty = Blueprint('_faculty', __name__)

@_faculty.route('/login_register_faculty', methods=['GET'])
def login_registerFaculty_view():
    auth_user=current_user
    if auth_user.is_authenticated:
        if auth_user.user_type == -1 or auth_user.user_type == 0:
            return redirect(url_for('.faculty_dashboard'))
        else:
            return redirect(url_for('_auth.index'))
            
    return render_template("Faculty/login_admin.html")

@_faculty.route('/register_faculty', methods=['GET'])
def register_faculty():    
    auth_user=current_user
    if auth_user.is_authenticated and auth_user.user_type == -1:
        return render_template("Faculty/register_admin.html")
    else:
        flash('Sorry only the admin is permitted to register a faculty account', category='error')
        return redirect(url_for('.faculty_dashboard'))

    
@_faculty.route('/login_faculty', methods=['GET', 'POST'])
def login_faculty():
    auth_user=current_user
    if auth_user.is_authenticated:
        if auth_user.user_type == -1 or auth_user.user_type == 0:
            return redirect(url_for('.faculty_dashboard'))
        else:
            return redirect(url_for('_auth.index'))
    else:
        if request.method == 'POST':
            user = User.query.filter_by(email=request.form['email'], department='faculty').first()
            print(user)
            if user:
                if check_password_hash(user.password, request.form['password']):
                    login_user(user, remember=True)
                    return redirect(url_for('.faculty_dashboard'))
                else:
                    flash('Invalid or wrong password', category='error')
            else:
                flash('No record found', category='error')
    return redirect(url_for('.login_registerFaculty_view'))


@_faculty.route('/faculty_dash', methods=['GET'])
@login_required
def faculty_dash():
    if request.method == 'GET':
        # Current Logged User
        auth_user=current_user
        page = request.args.get('page', 1, type=int)

        # Data for search
        search = request.args.getlist('search')
        search = (','.join(search))
        
        sex = request.args.getlist('sex')
        sex = (','.join(sex))
        
        print(search, sex)
        # Data for filter department
        # Return Data for template
        if auth_user.user_type == -1 or auth_user.user_type == 0:
            if search:
                students_record = db.session.query(User).filter(User.is_approve == 1, User.department == 'Faculty')\
                    .filter((User.first_name.like('%' + search + '%'))      |
                    (User.middle_name.like('%' + search + '%'))     |
                    (User.last_name.like('%' + search + '%'))       |
                    (User.desired_career.like('%' + search + '%'))         |
                    (User.contact_number.like('%' + search + '%'))  |
                    (User.department.like('%' + search + '%'))    |
                    (User.email.like('%' + search + '%')))\
                    .paginate(page=page, per_page=8)# fetch user students only
            elif sex:
                students_record = db.session.query(User).filter(User.is_approve == 1, User.department == 'Faculty')\
                    .filter((User.sex==sex))\
                    .paginate(page=page, per_page=8)# fetch sex only
            else:
                students_record = db.session.query(User).filter(User.is_approve == 1, User.department == 'Faculty').paginate(page=page, per_page=8)# fetch user students only

            auth_user=current_user
        else:
            return redirect(url_for('_auth.index'))
        
        return render_template("Faculty/faculty_dashboard.html", auth_user=auth_user, students_record=students_record, search=search, sex=sex)

@_faculty.route('/faculty_view', methods=['GET'])
@login_required
def faculty_view():
    if request.method == 'GET':
        # Current Logged User
        auth_user=current_user
        page = request.args.get('page', 1, type=int)

        # Data for search
        search = request.args.getlist('search')
        search = (','.join(search))

        department = request.args.getlist('department')
        department = (','.join(department))

        sex = request.args.getlist('sex')
        sex = (','.join(sex))

        curriculum_year = request.args.getlist('curriculum_year')
        curriculum_year = (','.join(curriculum_year))
        print(search, department, sex, curriculum_year)
        # Data for filter department
        # Return Data for template
        if auth_user.user_type == -1 or auth_user.user_type == 0:
            if search:
                students_record = db.session.query(User, PredictionResult).join(PredictionResult).filter(User.user_type == 1).where(PredictionResult.result_id == request.form['user_id'])\
                    .filter((User.first_name.like('%' + search + '%'))      |
                    (User.middle_name.like('%' + search + '%'))     |
                    (User.last_name.like('%' + search + '%'))       |
                    (User.desired_career.like('%' + search + '%'))         |
                    (User.contact_number.like('%' + search + '%'))  |
                    (User.department.like('%' + search + '%'))    |
                    (User.email.like('%' + search + '%')))\
                    .paginate(page=page, per_page=8)# fetch user students only
            elif department:
                students_record = db.session.query(User, PredictionResult).join(PredictionResult).filter(User.user_type == 1).where(PredictionResult.result_id == request.form['user_id'])\
                    .filter((User.department.like('%' + department + '%')))\
                    .paginate(page=page, per_page=8)# fetch department only
            elif sex:
                students_record = db.session.query(User, PredictionResult).join(PredictionResult).filter(User.user_type == 1).where(PredictionResult.result_id == request.form['user_id'])\
                    .filter((User.sex==sex))\
                    .paginate(page=page, per_page=8)# fetch department only
            elif curriculum_year:
                students_record = db.session.query(User, PredictionResult).join(PredictionResult).filter(User.user_type == 1).where(PredictionResult.result_id == request.form['user_id'])\
                    .filter((User.curriculum_year.like('%' + curriculum_year + '%')))\
                    .paginate(page=page, per_page=8)# fetch department only
            else:
                students_record = db.session.query(User, PredictionResult).join(PredictionResult).filter(User.user_type == 1).paginate(page=page, per_page=8).where(PredictionResult.result_id == request.form['user_id']) # fetch user students only

            auth_user=current_user
            unapprove_account = User.query.filter_by(is_approve = False, user_type = 1).all()
            count_unapprove = User.query.filter_by(is_approve = False, user_type = 1).count()
        else:
            return redirect(url_for('_auth.index'))

        return render_template("Faculty/faculty_view.html", auth_user=auth_user, students_record=students_record, unapprove_account=unapprove_account, count_unapprove=count_unapprove, search=search, department=department, sex=sex, curriculum_year=curriculum_year)

@_faculty.route('/faculty_dashboard', methods=['GET'])
@login_required
def faculty_dashboard():
    
    software_engineer_programmer = User.query.filter(User.desired_career.like('Software Engineer / Programmer'), User.user_type.like(1), User.is_approve.like(1)).count()
    
    technical_support_specialist = User.query.filter(User.desired_career.like('Technical Support Specialist'), User.user_type.like(1), User.is_approve.like(1)).count()
    
    academician = User.query.filter(User.desired_career.like('Academician'), User.user_type.like(1), User.is_approve.like(1)).count()
    
    administrative_assistant = User.query.filter(User.desired_career.like('Administrative Assistant'), User.user_type.like(1), User.is_approve.like(1)).count()
    
    male = User.query.filter(User.sex=='Male', User.user_type.like(1), User.is_approve.like(1)).count()
        
    female = User.query.filter(User.sex=='Female', User.user_type.like(1), User.is_approve.like(1)).count()
    
    registered_students =  User.query.filter(User.user_type.like(1), User.is_approve.like(1)).count()
    
    unregistered_students =  User.query.filter(User.user_type.like(1), User.is_approve.like(0)).count()
    
    if request.method == 'GET':
        # Current Logged User
        auth_user=current_user
        page = request.args.get('page', 1, type=int)

        # Data for search
        search = request.args.getlist('search')
        search = (','.join(search))
        
        department = request.args.getlist('department')
        department = (','.join(department))
        
        sex = request.args.getlist('sex')
        sex = (','.join(sex))
        
        curriculum_year = request.args.getlist('curriculum_year')
        curriculum_year = (','.join(curriculum_year))
        print(search, department, sex, curriculum_year)
        # Data for filter department
        # Return Data for template
        if auth_user.user_type == -1 or auth_user.user_type == 0:
            if search:
                students_record = db.session.query(User).filter(User.is_approve == 1, User.department != 'Faculty')\
                    .filter((User.first_name.like('%' + search + '%'))      |
                    (User.middle_name.like('%' + search + '%'))     |
                    (User.last_name.like('%' + search + '%'))       |
                    (User.desired_career.like('%' + search + '%'))         |
                    (User.contact_number.like('%' + search + '%'))  |
                    (User.department.like('%' + search + '%'))    |
                    (User.email.like('%' + search + '%')))\
                    .paginate(page=page, per_page=5)# fetch user students only
            elif department:
                students_record = db.session.query(User).filter(User.is_approve == 1, User.department != 'Faculty')\
                    .filter((User.department.like('%' + department + '%')))\
                    .paginate(page=page, per_page=5)# fetch department only
            elif sex:
                students_record = db.session.query(User).filter(User.is_approve == 1, User.department != 'Faculty')\
                    .filter((User.sex==sex))\
                    .paginate(page=page, per_page=5)# fetch sex only
            elif curriculum_year:
                students_record = db.session.query(User).filter(User.is_approve == 1, User.department != 'Faculty')\
                    .filter((User.curriculum_year.like('%' + curriculum_year + '%')))\
                    .paginate(page=page, per_page=5)# fetch curriculum year only
            else:
                students_record = db.session.query(User).filter(User.is_approve == 1, User.department != 'Faculty').paginate(page=page, per_page=5)# fetch user students only

            auth_user=current_user
            unapprove_account = User.query.filter_by(is_approve = False, user_type = 1).all()
            count_unapprove = User.query.filter_by(is_approve = False, user_type = 1).count()
        else:
            return redirect(url_for('_auth.index'))
        
        return render_template("Faculty/facultyEnd.html", auth_user=auth_user, 
                               students_record=students_record, 
                               unapprove_account=unapprove_account, 
                               count_unapprove=count_unapprove, search=search, 
                               department=department, sex=sex, curriculum_year=curriculum_year, 
                               software_engineer_programmer=json.dumps(software_engineer_programmer), technical_support_specialist=json.dumps(technical_support_specialist),
                               academician=json.dumps(academician), administrative_assistant=json.dumps(administrative_assistant),
                               male=json.dumps(male), female=json.dumps(female), registered_students=registered_students,
                               unregistered_students=unregistered_students
                               )

@_faculty.route('/view_results', methods=['POST'])
@login_required
def view_results():
    auth_user=current_user
    page = request.args.get('page', 1, type=int)
    view_pred_result = db.session.query(User, PredictionResult).filter(User.id == int(request.form['user_id'])).filter(PredictionResult.user_id == int(request.form['user_id'])).group_by(PredictionResult.result_id).paginate(page=page, per_page=8)

    return render_template("Faculty/faculty_view.html", view_pred_result=view_pred_result, auth_user=auth_user)

@_faculty.route('/delete_results', methods=['POST'])
@login_required
def delete_results():
    try:
        delete_pred_result = delete(PredictionResult).where(PredictionResult.result_id == request.form['user_id'])
        db.session.execute(delete_pred_result)
        db.session.commit()
        flash('History successfully deleted', category='success_deletion')
        return redirect(url_for('.faculty_dashboard'))
    except:
        flash('System error cannot delete data', category='error')
        return redirect(url_for('.faculty_dashboard'))

@_faculty.route('/delete_student', methods=['POST'])
@login_required
def delete_student():
    try:
        delete_result = delete(User).where(User.id == request.form['user_id'])
        db.session.execute(delete_result)
        db.session.commit()
        flash('Student account successfully deleted', category='success_deletion')
        return redirect(url_for('.faculty_dashboard'))
    except:
        flash('Delete the prediction history first to delete account', category='error')
        return redirect(url_for('.faculty_dashboard'))
    
@_faculty.route('/delete_faculty', methods=['POST'])
@login_required
def delete_faculty():
    auth_user=current_user
    
    if auth_user.is_authenticated and auth_user.user_type == -1:
        try:
            delete_result = delete(User).where(User.id == request.form['user_id'])
            db.session.execute(delete_result)
            db.session.commit()
            flash('Faculty account successfully deleted', category='success_deletion')
            return redirect(url_for('.faculty_dashboard'))
        except:
            flash('System error cannot delete data please try again', category='error')
            return redirect(url_for('.faculty_dashboard'))
        
    flash('Sorry only the admin is permitted to delete some data', category='error')
    return redirect(url_for('.faculty_dashboard'))

@_faculty.route('/approve_account', methods=['POST'])
@login_required
def approve_account():
    if int(request.form['approve_flag']) == 1:
        approve_account = User.query.filter_by(id=int(request.form['user_id'])).first()
        approve_account.is_approve = True
        db.session.commit()
        flash('Account successfully approved', category='success_deletion')
        return redirect(url_for('.faculty_dashboard'))
        # send_link(request.form['user_email'], request.form['user_department'])
    elif int(request.form['approve_flag']) == 0:
        approve_account = delete(User).where(User.id == request.form['user_id'])
        approve_account.is_approve = False
        db.session.execute(approve_account)
        db.session.commit()
        flash('Account successfully disapproved/deleted', category='success_deletion')
        return redirect(url_for('.faculty_dashboard'))
        # send_link_disapproved(request.form['user_email'])

    return redirect(url_for('_faculty.faculty_dashboard'))

@_faculty.route('/signup_Superadmin', methods=['POST'])
@login_required
def signup_Superadmin():
    try:
        new_user = User(request.form['first_name'], request.form['middle_name'], request.form['last_name'], request.form['sex'], '-------', request.form['contact_number'], request.form['email'], 'Faculty',  'Faculty', (generate_password_hash(request.form['password'], method="sha256")), True, 0)
        db.session.add(new_user)
        db.session.commit()
        flash('Account successfully created', category='success_register')
        return redirect(url_for('.register_faculty'))
    except:
        flash('Invalid credentials', category='error')
        return redirect(url_for('.register_faculty'))