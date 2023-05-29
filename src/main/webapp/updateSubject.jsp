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

	// SubjectDao 객체 선언
	SubjectDao subjectDao = new SubjectDao();
	Subject subject = subjectDao.selectSubjectOne(subjectNo);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Update Subject Information</title>
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
		input{
			width: 30%;
			padding: 5px;
		}
		textarea{
			padding: 10px;
			font-family: '맑은 고딕';
		}
		.error{
			height: 30px;
			color: red;
		}
		button{
			padding: 5px;
			border-radius: 4px;
			border: 1px solid #333333;
			background-color: FloralWhite;
			font-size: 16px;
			color: #333333;
			cursor: pointer;
		}
		button:hover{
			background-color: beige;
		}
	</style>
</head>
<body>
	<form action="<%=request.getContextPath() %>/updateSubjectAction.jsp" method="post">
		<div class="container">
			<h1>Update Subject Information</h1>
			<table>
				<tr>
					<th>번호</th>
					<td><input type="hidden" name="subjectNo" value="<%=subject.getSubjectNo()%>"><%=subject.getSubjectNo()%></td>
				</tr>
				<tr>
					<th>과목이름</th>
					<td><input type="text" name="subjectName" value="<%=subject.getSubjectName() %>" required></td>
				</tr>
				<tr>
					<th>시수</th>
					<td><input type="number" name="subjectTime" value="<%=subject.getSubjectTime()%>" required></td>
				</tr>
				<tr>
					<th>등록일자</th>
					<td><%=subject.getCreatedate() %></td>
				</tr>
				<tr>
					<th>수정일자</th>
					<td><%=subject.getUpdatedate() %></td>
				</tr>
			</table>
		</div>
		<div class="container">
			<button type="submit" formaction="<%=request.getContextPath() %>/subjectOne.jsp">이전</button>
			<button type="submit">수정</button>
		</div>
	</form>
</body>
</html>