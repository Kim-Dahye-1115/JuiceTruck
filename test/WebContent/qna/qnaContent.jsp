<!-- 
문의글 상세 페이지
문의내역 링크와 연결됨
관리자일때 답변작성 버튼 생성
첨부파일있을때 이미지 파일 링크로 열림
-->
<%@page import="javax.swing.text.AbstractDocument.Content"%>
<%@page import="com.admin.db.QnaBean"%>
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
		
		<h2>고객센터</h2>
		<!-- 페이지 이동-->
		<a href="./qnaWrite.qa">문의하기</a> 
		<a href="./qnaList.qa">문의내역</a> 
		<!-- 페이지 이동-->
		
		<%
		//request.setAttribute("qnaContent", qdao.getQnaContent(num));
		QnaBean qb = (QnaBean) request.getAttribute("qnaContent"); 
		String email = (String) session.getAttribute("email");
		//String email = "admin";
		
		//content 내용 줄바꿈 표시
		String content = null;
		if(qb.getQ_content() != null){
			content = qb.getQ_content().replace("\r\n", "<br>");
		}
		%>
		<!-- 테이블 -->	
		<table border="1">
			<tr>
		   		<td>카테고리</td>		
		   		<td><%=qb.getQ_category() %></td>		
				<td>작성자</td>
				<td><%=qb.getNick() %></td>
			</tr>
			<tr>
			   	<td >제목</td>
			   	<td ><%=qb.getQ_subject() %></td>
			   	<td >등록일</td>
		   		<td><%=qb.getQ_date() %></td>
			</tr>
			<tr>
				<td colspan="4">내용</td>
			</tr>
			<tr>
		   		<td colspan="4">
		    	<%=content %>
		   		</td>
			</tr>
			<%if(qb.getFiles()!=null){ %>
<!-- 수정 -->
			<tr>
				<td>첨부파일</td>
				<td>
					<a href="./upload/<%=qb.getFiles()%>" onclick="window.open(this.href,'_blank','width=1000, height=500'); return false;"><%=qb.getFiles() %></a>
				</td>
			</tr>
<!-- 수정끝 -->
			<%} %>
		</table>
		<!-- 테이블 -->	
		
		<!-- 서브밋 버튼 -->	
			<%
			//회원문의에 (관리자) 답변 버튼 생성
			if(email.equals("admin@itwill.com")){ 
			%>
				<input type="submit" value="답변작성" 
						onclick="location.href='./AdminQnaWrite.qa?num=<%=qb.getQ_num()%>'">
			<%} %>
		<!-- 서브밋 버튼 -->	
					
		<!-- 푸터 -->
		<jsp:include page="../inc/bottom.jsp"/>
		<!-- 푸터 -->		
	</body>
</html>