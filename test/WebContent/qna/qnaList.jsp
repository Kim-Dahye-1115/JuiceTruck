<!-- 
문의글 리스트 페이지
-->
<%@page import="com.admin.action.pagingVO"%>
<%@page import="com.admin.db.QnaBean"%>
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
		<br><br><br><br><br><br><br>
		
		<%
			String email = (String) session.getAttribute("email");
			List qnaList = (List) request.getAttribute("qnaList");
			pagingVO pv = (pagingVO) request.getAttribute("pagingVO");
		%>
		
		<h2>고객센터</h2>
		<!-- 페이지 이동-->
			<a href="./qnaWrite.qa">문의하기</a> 
			<a href="./qnaList.qa">문의내역</a> 
		<!-- 페이지 이동-->
		
		<!-- 테이블 -->	 
		<table>
		<!-- 제목 -->	 
			<tr>
				<td>분류</td>
				<td>제목</td>
				<td>작성일</td>
			</tr>
		<!-- 제목 -->	 
		
		<!-- 게시글 -->	 
		<%
		for(int i=0;i<qnaList.size();i++){
					  QnaBean qb = (QnaBean) qnaList.get(i);
			    	%> 
					<tr>
						<td><%=qb.getQ_category() %></td>
						<td>
						<%if(qb.getQ_num()>qb.getQ_re_ref()){%>
		 					<!-- 작성자가 관리자일때 답글 이미지 추가-->
							<i class="material-icons">subdirectory_arrow_right</i>
						<%} %>
		 					<a href="./qnaContent.qa?num=<%=qb.getQ_num() %>"> 
		 					<%=qb.getQ_subject() %></a> 
						</td>
		 	    		<td><%=qb.getQ_date() %></td> 
			    	</tr>
					<% 
				}
		     	%> 
			</table>
		<!-- 게시글 -->
		<!-- 테이블 -->
		
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
				<a href="./qnaList.qa?pageNum=<%=startPage-pageBlock%>">이전</a> 
		<%
			}
			for(int i=startPage;i<=endPage;i++){
		%>
				<a href="./qnaList.qa?pageNum=<%=i%>"><%=i %></a>
		<%
			}
			if(endPage<pageCount){
		%>
				<a href="./qnaList.qa?pageNum=<%=startPage+pageBlock%>">다음</a>
		<%
			}
		}
		%>
		<!-- 페이징 -->
		
		<!-- 푸터 -->
		<jsp:include page="../inc/bottom.jsp"/>
		<!-- 푸터 -->
	
	</body>
</html>