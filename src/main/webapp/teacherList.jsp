<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	//현재 페이지값 저장
	int currentPage = 1;
	if(request.getParameter("currentPage") != null
	&& !request.getParameter("currentPage").equals("")){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// db요청을 다뤄줄 dao선언
	TeacherDao teacherDao = new TeacherDao();
	
	// 전체 선생님 수 받아오기
	int totalCnt = teacherDao.selectTeacherCnt();
	
	// 페이징 변수 선언
	int rowPerPage = 5;
	int beginRow = (currentPage - 1) * rowPerPage;
	
	int pagePerPage = 10;
	int startPage = (currentPage - 1) / rowPerPage * rowPerPage + 1;
	
	int lastPage = totalCnt / rowPerPage;
	if(totalCnt % rowPerPage != 0){
		lastPage++;
	}
	
	int endPage = startPage + pagePerPage - 1;
	if(endPage > lastPage){
		endPage = lastPage;
	}
	
	//현재 페이지에 해당하는 데이터 가져오기
	ArrayList<HashMap<String, Object>> list = teacherDao.selectTeacherListByPage(beginRow, rowPerPage);
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Teacher List</title>
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
			padding: 5px;
		}
		td{
			border: 1px solid #333333;
			padding: 10px;
		}
		a{
			color: blue;
			text-decoration: underline;
		}
		.selected{
			color: red;
			text-decoration: none;
		}
	</style>
</head>
<body>
<div class="container">
		<h1>Teacher List</h1>
		<table>
			<tr>
				<td>번호</td>
				<td>아이디</td>
				<td>성함</td>
				<td>담당과목번호</td>
				<td>담당과목</td>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
			</tr>
			<%
				for(HashMap<String, Object> m : list){
			%>
					<tr>
						<td><%=(Integer)m.get("teacherNo") %></td>
						<td><%=(String)m.get("teacherId") %></td>
						<td><%=(String)m.get("teacherName") %></td>
						<td><%=(String)m.get("teacherSubjectNo") %></td>
						<td><%=(String)m.get("teacherSubjectName") %></td>
						<td>
							<a href="<%=request.getContextPath() %>/teacherOne.jsp?subjectNo=<%=(Integer)m.get("teacherNo")%>">상세보기</a>
						</td>
					</tr>
			<%
				}
			%>
		</table>
	</div>
	<div class="container">
			<%
				if(startPage != 1){
			%>
					<a href="teacherList.jsp?currentPage=<%=endPage - 1%>">이전</a>
			<%
				}
			
				for(int i = startPage; i <= endPage; i++){
					String selected = i == currentPage ? "selected" : "";
			%>
					<a href="teacherList.jsp?currentPage=<%=i %>" class=<%=selected %>><%=i %></a>
			<%
				}
				if(endPage != lastPage){
			%>
					<a href="teacherList.jsp?currentPage=<%=startPage - pagePerPage%>">다음</a>
			<%
				}
			%>
	</div>
</body>
</html>