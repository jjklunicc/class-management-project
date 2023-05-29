<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.net.*"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	request.setCharacterEncoding("utf-8");

	// 요청값 유효성 검사
	if(request.getParameter("subjectNo") == null
	|| request.getParameter("subjectNo").equals("")){
		response.sendRedirect(request.getContextPath() + "/subjectList.jsp");
		return;
	}
	
	// 요청값 저장
	int subjectNo = Integer.parseInt(request.getParameter("subjectNo"));
	String subjectName = request.getParameter("subjectName");
	int subjectTime = Integer.parseInt(request.getParameter("subjectTime"));
	
	// 업데이트 요청할 데이터 생성
	Subject subject = new Subject();
	subject.setSubjectNo(subjectNo);
	subject.setSubjectName(subjectName);
	subject.setSubjectTime(subjectTime);
	
	// SubjectDao 객체 선언
	SubjectDao subjectDao = new SubjectDao();
	
	// 실행 후 결과 저장
	int row = subjectDao.UpdateSubject(subject);
	
	if(row == 1){
		response.sendRedirect(request.getContextPath() + "/subjectOne.jsp?subjectNo=" + subjectNo);
		return;
	}else{
		String err = URLEncoder.encode("수정실패", "utf-8");
		response.sendRedirect(request.getContextPath() + "/updateSubject.jsp?subjectNo=" + subjectNo + "&msg=" + err);
	}
%>