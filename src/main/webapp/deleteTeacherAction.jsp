<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%
	// 요청값 유효성 검사
	if(request.getParameter("teacherNo") == null
	|| request.getParameter("teacherNo").equals("")){
		response.sendRedirect(request.getContextPath() + "/teacherList.jsp");
		return;
	}

	// 요청값 저장
	int teacherNo = Integer.parseInt(request.getParameter("teacherNo"));
	
	// teacherDao 객체 선언
	TeacherDao teacherDao = new TeacherDao();
	
	// 실행 후 결과 저장
	int row = teacherDao.deleteTeacher(teacherNo);
	
	response.sendRedirect(request.getContextPath() + "/teacherList.jsp");
%>