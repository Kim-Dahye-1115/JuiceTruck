<!-- 
공지사항 리스트 페이지
페이징, (관리자)글쓰기버튼
-->
<%@page import="com.admin.db.NoticeBean"%>
<%@page import="com.admin.action.pagingVO"%>
<%@page import="java.util.List"%>
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
		<%
			String email = (String) session.getAttribute("email");
			List noticeList = (List) request.getAttribute("noticeList");
			pagingVO pv = (pagingVO) request.getAttribute("pagingVO");
		%>
		
		<h2>공지사항</h2>
		<!-- 테이블 -->
		<table border="1">
			<tr>
				<td>번호</td>
				<td>제목</td>
				<td>작성일</td>
				<td>조회</td>
			</tr>
			<%
			for(int i=0; i<noticeList.size();i++){
				NoticeBean nb = (NoticeBean)noticeList.get(i);
			%>
				<tr>
					<td><%=nb.getN_num() %></td>
					<td><a href="./noticeContent.no?num=<%=nb.getN_num()%>&pageNum=<%=pv.getN_pageNum()%>"><%=nb.getN_title() %></a></td>
					<td><%=nb.getN_date() %></td>
					<td><%=nb.getN_read_count() %></td>
				</tr>
			<%
			}
			%>
		</table>
		<!-- 테이블 -->
		<!-- 관리자일때  -->
		<%if(email.equals("admin@itwill.com")) {%>
		<!-- 버튼 -->
			<button onclick="location.href='./noticeWrite.no'">글쓰기</button>
		<!-- 버튼 -->
		<%} %>
		
		<!-- 페이징 -->
		<%
		int cnt = pv.getN_noticeCount();
		int pageBlock = pv.getN_pageBlock();
		int pageNum = pv.getN_pageNum();
		int pageSize = pv.getN_pageSize();
		if(pv.getN_noticeCount() != 0){
			//전체 페이지수
			int pageCount = cnt/pageSize+(cnt%pageSize==0? 0:1);
			//pageBlock 시작 번호
			int startPage = ((pageNum-1)/pageBlock)*pageBlock+1;
			//pageBlock 끝 번호
			int endPage = startPage+pageBlock-1;
			if(endPage>pageCount){
				endPage=pageCount;
			}
			
			if(startPage>pageBlock){
		%>
				<a href="./noticeList.no?pageNum=<%=startPage-pageBlock%>">이전</a> 
		<%
			}
			for(int i=startPage;i<=endPage;i++){
		%>
				<a href="./noticeList.no?pageNum=<%=i%>"><%=i %></a>
		<%
			}
			if(endPage<pageCount){
		%>
				<a href="./noticeList.no?pageNum=<%=startPage+pageBlock%>">다음</a>
		<%
			}
		}
		%>
		<!-- 페이징 -->
		<!-- 검색창 -->
		<div class="col-md-4 ml-auto mr-auto">
			<form class="text-center" action="./noticeList.no" method="get">
				<input type="text" class="form-control" name="search">
				<button type="submit" class="btn btn-primary btn-link search">
					<i class="material-icons searchicon">search</i></button>
			</form>
		</div>
		<!-- 검색창 -->
		<!-- 푸터 -->
		<jsp:include page="../inc/bottom.jsp"/>
		<!-- 푸터 -->
	</body>
</html>