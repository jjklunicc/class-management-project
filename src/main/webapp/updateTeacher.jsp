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
	<title>Update Teacher Information</title>
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
	<form action="<%=request.getContextPath() %>/updateTeacherAction.jsp" method="post">
		<div class="container">
			<h1>Update Teacher Information</h1>
			<table>
				<tr>
					<th>번호</th>
					<td><input type="hidden" name="teacherNo" value="<%=teacher.getTeacherNo()%>" readonly><%=teacher.getTeacherNo()%></td>
				</tr>
				<tr>	
					<th>아이디</th>
					<td><input name="teacherId" value=<%=teacher.getTeacherId() %> required></td>
				</tr>
				<tr>	
					<th>성함</th>
					<td><input name="teacherName" value=<%=teacher.getTeacherName() %> required></td>
				</tr>
				<tr>	
					<th>메모</th>
					<td><textarea name="teacherHistory" rows="3" cols="100" required><%=teacher.getTeacherHistory() %></textarea></td>
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
			<button type="submit" formaction="<%=request.getContextPath()%>/teacherOne.jsp">이전</button>
			<button type="submit">수정</button>
		</div>
	</form>
</body>
</html>