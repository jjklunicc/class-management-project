<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert Subject Information</title>
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
	<form action="<%=request.getContextPath() %>/insertSubjectAction.jsp" method="post">
		<div class="container">
			<h1>Insert Subject Information</h1>
			<table>
				<tr>
					<th>과목이름</th>
					<td><input type="text" name="subjectName" required></td>
				</tr>
				<tr>	
					<th>시수</th>
					<td><input type="number" name="subjectTime" required></td>
				</tr>
			</table>
		</div>
		<div class="container">
			<a href="<%=request.getContextPath()%>/subjectList.jsp">이전</a>
			<button type="submit">입력</button>
		</div>
	</form>
</body>
</html>