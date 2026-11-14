package com.student.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.student.model.*;

public class StudentDao {

    private String url = "jdbc:mysql://localhost:3306/studentmanagmentsystem";
    private String uname = "root";
    private String upass = "qwertsql@440";
    private String driver = "com.mysql.cj.jdbc.Driver";


    public List<Student> getAllStudents() {
        List<Student> students = new ArrayList<>();
        try {
            Class.forName(driver);
            Connection conn = DriverManager.getConnection(url, uname, upass);
            String sql = "SELECT * FROM student_info";
            ResultSet rs = conn.createStatement().executeQuery(sql);
            while (rs.next()) {
                students.add(new Student(rs.getInt(1), rs.getString(2)));
            }
            conn.close();
        } catch (Exception e) { e.printStackTrace(); }
        return students;
    }

    
    public List<Department> getAllDepartment() {
        List<Department> list = new ArrayList<>();
        try {
            Class.forName(driver);
            Connection conn = DriverManager.getConnection(url, uname, upass);
            ResultSet rs = conn.createStatement().executeQuery("SELECT * FROM departments");
            while (rs.next()) {
                list.add(new Department(rs.getInt(1), rs.getString(2), rs.getInt(3)));
            }
            conn.close();
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

 
    public List<Course> getAllCourses() {
        List<Course> list = new ArrayList<>();
        try {
            Class.forName(driver);
            Connection conn = DriverManager.getConnection(url, uname, upass);
            ResultSet rs = conn.createStatement().executeQuery("SELECT * FROM studentcourse");
            while (rs.next()) {
                list.add(new Course(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getString(4)));
            }
            conn.close();
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }


    public void registerStudentFully(int id, String name, String dept, String course) {
        String sqlStudent = "INSERT INTO student_info (StudentId, StudentName) VALUES (?, ?)";
        String sqlDept = "INSERT INTO departments (departmentid, departmentname, studentId) VALUES (?, ?, ?)";
        String sqlCourse = "INSERT INTO studentcourse (studentid, studentname, courseid, coursename) VALUES (?, ?, ?, ?)";

        try {
            Class.forName(driver);
            Connection conn = DriverManager.getConnection(url, uname, upass);

            
            PreparedStatement ps1 = conn.prepareStatement(sqlStudent);
            ps1.setInt(1, id);
            ps1.setString(2, name);
            ps1.executeUpdate();

      
            PreparedStatement ps2 = conn.prepareStatement(sqlDept);
            ps2.setInt(1, 100 + id);
            ps2.setString(2, dept);  
            ps2.setInt(3, id);
            ps2.executeUpdate();

          
            PreparedStatement ps3 = conn.prepareStatement(sqlCourse);
            ps3.setInt(1, id);
            ps3.setString(2, name);
            ps3.setInt(3, 500 + id); 
            ps3.setString(4, course); 
            ps3.executeUpdate();

            conn.close();
            System.out.println("Full registration successful!");
        } catch (Exception e) { e.printStackTrace(); }
    }
}