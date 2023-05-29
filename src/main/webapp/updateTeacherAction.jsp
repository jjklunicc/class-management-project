<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	request.setCharacterEncoding("utf-8");

	// 요청값 유효성 검사
	if(request.getParameter("teacherNo") == null
	|| request.getParameter("teacherNo").equals("")){
		response.sendRedirect(request.getContextPath() + "/teacherList.jsp");
		return;
	}

	// 요청값 저장
	int teacherNo = Integer.parseInt(request.getParameter("teacherNo"));
	String teacherId = request.getParameter("teacherId");
	String teacherName = request.getParameter("teacherName");
	String teacherHistory = request.getParameter("teacherHistory");
	
	// 업데이트 요청할 데이터 생성
	Teacher teacher = new Teacher();
	teacher.setTeacherNo(teacherNo);
	teacher.setTeacherId(teacherId);
	teacher.setTeacherName(teacherName);
	teacher.setTeacherHistory(teacherHistory);
	
	// teacherDao 객체 선언
	TeacherDao teacherDao = new TeacherDao();
	
	//실행 후 결과 저장
	int row = teacherDao.updateTeacher(teacher);
	
	if(row == 1){
		response.sendRedirect(request.getContextPath() + "/teacherOne.jsp?teacherNo=" + teacherNo);
		return;
	}else{
		String err = URLEncoder.encode("수정실패", "utf-8");
		response.sendRedirect(request.getContextPath() + "/updateTeacher.jsp?teacherNo=" + teacherNo + "&msg=" + err);
	}
	
%>