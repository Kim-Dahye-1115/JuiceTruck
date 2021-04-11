<!-- 
공지사항 글 내용
(관리자)글 삭제 가능
-->
<%@page import="com.admin.db.NoticeBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	</head>
	<body>
		<!-- 헤더 -->
		<jsp:include page="../inc/top.jsp"/>
		<!-- 헤더 -->
		<br><br><br><br><br><br>
		
		<h2>공지사항</h2>
		<%
		NoticeBean nb = (NoticeBean) request.getAttribute("noticeContent");
		String pageNum = (String) request.getAttribute("pageNum");
		System.out.print("Content 받아온 페이지 넘버"+pageNum);
		String email = (String) session.getAttribute("email");
		
		//content 내용 줄바꿈 표시
		String content = null;
		if(nb.getN_content() != null){
			content = nb.getN_content().replace("\r\n", "<br>");
		}
		%>
		
		<!-- 테이블 -->
		<table border="1">
			<tr>
				<td><%=nb.getN_title() %></td>
				<td><%=nb.getN_date() %></td>
				<td><%=nb.getN_read_count() %></td>
			</tr>
			<tr>
				<td colspan="3"><%=nb.getN_content() %></td>
			</tr>
		</table>
		<!-- 테이블 -->
		
		<!-- 버튼 -->
		<button onclick="location.href='./noticeList.no?pageNum=<%=pageNum%>'">목록</button>
		<!-- 관리자일떄-->
		<%if(email.equals("admin@itwill.com")){ %>
			<button onclick="location.href='./noticeDelete.no?num=<%=nb.getN_num()%>'">삭제</button>
		<%} %>
		<!-- 버튼 -->
		
		<!-- 푸터 -->
		<jsp:include page="../inc/bottom.jsp"/>
		<!-- 푸터 -->
	</body>
</html>