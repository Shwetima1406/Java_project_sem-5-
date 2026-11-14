<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.student.model.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Management System</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f7f6;
            margin: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 40px;
        }
        h2 { 
        		color: #2c3e50; 
        		margin-bottom: 20px; 
        }
        .container {
            background: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 500px;
            margin-bottom: 30px;
        }
        .form-group { 
        		margin-bottom: 15px;
        }
        label {
        		display: block; 
        		margin-bottom: 5px; 
        		font-weight: bold; 
        		color: #34495e; }
        input[type="number"], input[type="text"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            width: 100%;
            background-color: #27ae60;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background 0.3s;
        }
        input[type="submit"]:hover { background-color: #219150; }
        .tab-container { 
            margin: 20px 0; 
            display: flex; 
            gap: 15px; 
            justify-content: center; 
        }
        .btn-tab { 
            padding: 12px 25px; 
            cursor: pointer; 
            background-color: #2c3e50; 
            color: white; 
            border: none; 
            border-radius: 6px; 
            font-weight: bold; 
            transition: 0.3s;
        }
        .btn-tab:hover { background-color: #34495e; }
        table {
            width: 100%;
            max-width: 900px;
            border-collapse: collapse;
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        th, td { padding: 15px; text-align: left; border-bottom: 1px solid #eee; }
        th { background-color: #2980b9; color: white; text-transform: uppercase; font-size: 14px; }
        tr:hover { background-color: #f9f9f9; }
        .empty-msg { text-align: center; color: #7f8c8d; padding: 20px; }
        .data-section { display: none; width: 100%; }
        .active-section { display: flex; flex-direction: column; align-items: center; animation: fadeIn 0.4s; }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>

    <h2>🎓 Student Administration</h2>

    <div class="container">
        <h3 style="margin-top:0; color: #2980b9;">Add New Record</h3>
        <form action="viewStudents" method="post">
            <div class="form-group">
                <label>Student ID</label>
                <input type="number" name="sId" placeholder="e.g. 101" required>
            </div>
            <div class="form-group">
                <label>Full Name</label>
                <input type="text" name="sName" placeholder="e.g. Deep" required>
            </div>
            <div class="form-group">
                <label>Department Name</label>
                <input type="text" name="deptName" placeholder="e.g. Electronics" required>
            </div>
            <div class="form-group">
                <label>Course Name</label>
                <input type="text" name="courseName" placeholder="e.g. Java" required>
            </div>
            <input type="submit" value="Register Complete Student">
        </form>
    </div>

    <div class="tab-container">
        <button class="btn-tab" onclick="toggleTable('studentTable')">View Students</button>
        <button class="btn-tab" onclick="toggleTable('deptTable')">View Departments</button>
        <button class="btn-tab" onclick="toggleTable('courseTable')">View Courses</button>
    </div>

    <div id="studentTable" class="data-section active-section">
        <h3>Registered Students</h3>
        <table>
            <thead>
                <tr>
                    <th>Registration ID</th>
                    <th>Student Name</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    List<Student> studentList = (List<Student>) request.getAttribute("allStudents");
                    if (studentList != null && !studentList.isEmpty()) {
                        for (Student s : studentList) {
                %>
                    <tr>
                        <td><strong><%= s.getId() %></strong></td>
                        <td><%= s.getName() %></td>
                    </tr>
                <% } } else { %>
                    <tr><td colspan="2" class="empty-msg">No records found.</td></tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <div id="deptTable" class="data-section">
        <h3>University Departments</h3>
        <table>
            <thead>
                <tr>
                    <th>Dept ID</th>
                    <th>Department Name</th>
                    <th>Student ID</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    List<Department> depts = (List<Department>) request.getAttribute("allDepts");
                    if (depts != null && !depts.isEmpty()) {
                        for (Department d : depts) {
                %>
                    <tr>
                        <td><strong><%= d.getDepartmentId() %></strong></td>
                        <td><%= d.getDepartmentName() %></td>
                        <td><%= d.getStudentId() %></td>
                    </tr>
                <% } } %>
            </tbody>
        </table>
    </div>

    <div id="courseTable" class="data-section">
        <h3>Course Enrollment</h3>
        <table>
            <thead>
                <tr>
                    <th>Student ID</th>
                    <th>Name</th>
                    <th>Course ID</th>
                    <th>Course</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    List<Course> courseList = (List<Course>) request.getAttribute("allCourses");
                    if (courseList != null && !courseList.isEmpty()) {
                        for (Course c : courseList) {
                %>
                    <tr>
                        <td><%= c.getStudentId() %></td>
                        <td><%= c.getStudentName() %></td>
                        <td><strong><%= c.getCourseId() %></strong></td>
                        <td><%= c.getCourseName() %></td>
                    </tr>
                <% } } %>
            </tbody>
        </table>
    </div>

    <script>
        function toggleTable(id) {
            document.querySelectorAll('.data-section').forEach(section => {
                section.classList.remove('active-section');
            });
            const target = document.getElementById(id);
            if(target) {
                target.classList.add('active-section');
            }
        }
    </script>
</body>
</html>