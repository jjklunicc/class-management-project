<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// 요청값 유효성 검사
	if(request.getParameter("teacherNo") == null
	|| request.getParameter("teacherNo").equals("")){
		response.sendRedirect(request.getContextPath() + "/teacherList.jsp");
		return;
	}
	
	// 요청값 저장
	int teacherNo = Integer.parseInt(request.getParameter("teacherNo"));
	
	// teacher db를 실행시킬 dao선언
	TeacherDao teacherDao = new TeacherDao();
	
	// teacherNo에 대한 데이터 불러오기
	HashMap<String, Object> map = teacherDao.selectTeacherOne(teacherNo);
	Teacher teacher = (Teacher)map.get("teacher");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Teacher Detail Information</title>
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
		<h1>Teacher Detail Information</h1>
		<table>
			<tr>
				<th>번호</th>
				<td><%=teacher.getTeacherNo()%></td>
			</tr>
			<tr>	
				<th>아이디</th>
				<td><%=teacher.getTeacherId() %></td>
			</tr>
			<tr>	
				<th>성함</th>
				<td><%=teacher.getTeacherName() %></td>
			</tr>
			<tr>	
				<th>메모</th>
				<td><%=teacher.getTeacherHistory() %></td>
			</tr>
			<tr>	
				<th>등록일자</th>
				<td><%=teacher.getCreatedate() %></td>
			</tr>	
			<tr>
				<th>정보수정일자</th>
				<td><%=teacher.getUpdatedate() %></td>
			</tr>
			<tr>	
				<th>담당과목번호</th>
				<td><%=(String)map.get("teacherSubjectNo") %></td>
			</tr>
			<tr>	
				<th>담당과목명</th>
				<td><%=(String)map.get("teacherSubjectName") %></td>
			</tr>
		</table>
	</div>
	<div class="container">
		<a href="<%=request.getContextPath() %>/teacherList.jsp">이전</a>
		<a href="<%=request.getContextPath() %>/updateTeacher.jsp?teacherNo=<%=teacher.getTeacherNo() %>">수정</a>
		<a href="<%=request.getContextPath() %>/deleteTeacherAction.jsp?teacherNo=<%=teacher.getTeacherNo() %>">삭제</a>
	</div>
</body>
</html>