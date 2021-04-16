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
<div class="main main-raised">
	<div class="container">
		<div class="section section-text">
			<div class="row">
 				<div class="col-md-9 ml-auto mr-auto"> 	
			
					<h3 class="title">고객센터</h3>
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
					<div class="table-responsive">
						<table class="table adminList">
							<tr>
						   		<th class="adminW3">카테고리</th>		
						   		<td><%=qb.getQ_category() %></td>		
								<th class="adminW3">작성자</th>
								<td class="adminW4"><%=qb.getNick() %></td>
							</tr>
							<tr>
							   	<th>제목</th>
							   	<td><%=qb.getQ_subject() %></td>
							   	<th>등록일</th>
						   		<td><%=qb.getQ_date() %></td>
							</tr>
							<tr>
								<th colspan="4">내용</th>
							</tr>
							<tr>
						   		<td colspan="4">
						    	<%=content %>
						   		</td>
							</tr>
							<%if(qb.getFiles()!=null){ %>
				<!-- 수정 -->
							<tr>
								<th>첨부파일</th>
								<td>
									<a href="./upload/<%=qb.getFiles()%>" onclick="window.open(this.href,'_blank','width=1000, height=500'); return false;"><%=qb.getFiles() %></a>
								</td>
							</tr>
				<!-- 수정끝 -->
							<%} %>
						</table>
					</div>
					<!-- 테이블 -->	
					
					<!-- 서브밋 버튼 -->
						<%
						//회원문의에 (관리자) 답변 버튼 생성
						if(email.equals("juicetruck.ad@gmail.com")&&!(qb.getNick().equals("관리자"))){ 
						%>
						<div class="col-md-5 ml-auto mr-auto fileadd6">
							<input type="submit" value="답변작성" class="btn btn-primary"
									onclick="location.href='./AdminQnaWrite.qa?num=<%=qb.getQ_num()%>'">
						<%}else { %>
						<div class="col-md-2 ml-auto mr-auto fileadd6">
							<input type="submit" value="답변작성" class="btn btn-primary adminHide"
									onclick="location.href='./AdminQnaWrite.qa?num=<%=qb.getQ_num()%>'">
						<%} %>
							<input type="button" class="btn btn-primary" value="목록" class="btn btn-primary" onclick="location.href='./qnaList.qa'">
						</div>
					<!-- 서브밋 버튼 -->	
				</div>
			</div>
		</div>
	</div>
</div>										
		<!-- 푸터 -->
		<jsp:include page="../inc/bottom.jsp"/>
		<!-- 푸터 -->		
	</body>
</html>