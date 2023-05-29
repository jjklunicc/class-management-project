<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// 요청값 유효성 검사
	if(request.getParameter("subjectNo") == null
	|| request.getParameter("subjectNo").equals("")){
		response.sendRedirect(request.getContextPath() + "/subjectList.jsp");
		return;
	}

	// 요청값 저장
	int subjectNo = Integer.parseInt(request.getParameter("subjectNo"));
	
	// subjectDao 객체 선언
	SubjectDao subjectDao = new SubjectDao();
	
	// subjectNo에 해당하는 데이터 불러오기
	Subject subject = subjectDao.selectSubjectOne(subjectNo);	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Subject Detail Information</title>
	<style>
		.container{
			width: 1280px;
			margin: 0 auto;
			text-align: center;
		}
		.container + .container{
			margin-top: 20px;
		}
		table{
			width: 100%;
			border: 1px solid #333333;
			border-collapse: collapse;
			padding: 5px;
		}
		td,th{
			border: 1px solid #333333;
			padding: 20px;
		}
		th{
			background-color: lightblue;
			width: 20%;
		}
		a{
			padding: 5px;
			border-radius: 4px;
			border: 1px solid #333333;
			background-color: FloralWhite;
			color: #333333;
			text-decoration: none;
		}
		a:hover{
			background-color: lightgray;
		}
	</style>
</head>
<body>
	<div class="container">
		<h1>Subject Detail Information</h1>
		<table>
			<tr>
				<th>번호</th>
				<td><%=subject.getSubjectNo()%></td>
			</tr>
			<tr>	
				<th>과목이름</th>
				<td><%=subject.getSubjectName() %></td>
			</tr>
			<tr>	
				<th>시수</th>
				<td><%=subject.getSubjectTime() %></td>
			</tr>
			<tr>	
				<th>등록일자</th>
				<td><%=subject.getCreatedate() %></td>
			</tr>	
			<tr>
				<th>정보수정일자</th>
				<td><%=subject.getUpdatedate() %></td>
			</tr>
		</table>
	</div>
	<div class="container">
		<a href="<%=request.getContextPath() %>/subjectList.jsp">이전</a>
		<a href="<%=request.getContextPath() %>/updateSubject.jsp?subjectNo=<%=subject.getSubjectNo() %>">수정</a>
		<a href="<%=request.getContextPath() %>/deleteSubjectAction.jsp?subjectNo=<%=subject.getSubjectNo() %>">삭제</a>
	</div>
</body>
</html>