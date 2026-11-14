package com.student.model;

public class Department {
 private int departmentId;
 private String departmentName;
 private int studentId;
 
 public Department(int departmentId, String departmentName, int studentId) {
	 this.departmentId=departmentId;
	 this.departmentName=departmentName;
	 this.studentId=studentId;
 }

 public int getDepartmentId() {
	return departmentId;
 }

 public void setDepartmentId(int departmentId) {
	this.departmentId = departmentId;
 }

 public String getDepartmentName() {
	return departmentName;
 }

 public void setDepartmentName(String departmentName) {
	this.departmentName = departmentName;
 }

 public int getStudentId() {
	return studentId;
 }

 public void setStudentId(int studentId) {
	this.studentId = studentId;
 }
 
 
 
}
