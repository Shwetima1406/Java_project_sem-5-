package com.student.controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.student.dao.StudentDao;
import com.student.model.*;

@WebServlet("/viewStudents")
public class StudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String method = req.getMethod();
        StudentDao dao = new StudentDao();

        if (method.equalsIgnoreCase("Post")) {
            try {
                int id = Integer.parseInt(req.getParameter("sId"));
                String name = req.getParameter("sName");
                String dept = req.getParameter("deptName");
                String course = req.getParameter("courseName");

                dao.registerStudentFully(id, name, dept, course);
                res.sendRedirect("viewStudents");
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            List<Student> studentList = dao.getAllStudents();
            List<Department> deptList = dao.getAllDepartment();
            List<Course> courseList = dao.getAllCourses();

            req.setAttribute("allStudents", studentList);
            req.setAttribute("allDepts", deptList);
            req.setAttribute("allCourses", courseList);

            RequestDispatcher rd = req.getRequestDispatcher("displayStudents.jsp");
            rd.forward(req, res);
        }
    }
}