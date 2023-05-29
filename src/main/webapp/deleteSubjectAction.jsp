<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%
	// 요청값 유효성 검사
	if(request.getParameter("subjectNo") == null
	|| request.getParameter("subjectNo").equals("")){
		response.sendRedirect(request.getContextPath() + "/subjectList.jsp");
		return;
	}

	// 요청값 저장
	int subjectNo = Integer.parseInt(request.getParameter("subjectNo"));
	
	// SubjectDao 객체 선언
	SubjectDao subjectDao = new SubjectDao();
	
	// 실행 후 결과 저장
	int row = subjectDao.deleteSubject(subjectNo);
	
	response.sendRedirect(request.getContextPath() + "/subjectList.jsp");
%>