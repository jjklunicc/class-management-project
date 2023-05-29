<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	request.setCharacterEncoding("utf-8");

	// 요청값 저장
	String subjectName = request.getParameter("subjectName");
	int subjectTime = Integer.parseInt(request.getParameter("subjectTime"));
	
	// 입력할 정보를 담은 subject객체 생성
	Subject subject = new Subject();
	subject.setSubjectName(subjectName);
	subject.setSubjectTime(subjectTime);
	
	// SubjectDao 객체 생성
	SubjectDao subjectDao = new SubjectDao();
	
	// insert 실행 후 결과 저장
	int row = subjectDao.insertSubject(subject);
	System.out.println("insertSubjectAction row : " + row);
	
	response.sendRedirect(request.getContextPath() + "/subjectList.jsp");
%>
