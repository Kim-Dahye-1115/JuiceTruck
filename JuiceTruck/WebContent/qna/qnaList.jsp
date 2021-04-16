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
		
		<%
			String email = (String) session.getAttribute("email");
			List qnaList = (List) request.getAttribute("qnaList");
			pagingVO pv = (pagingVO) request.getAttribute("pagingVO");
		%>
<div class="main main-raised">
	<div class="container">
		<div class="section section-text">
			<div class="row">
 				<div class="col-md-9 ml-auto mr-auto"> 
					<h2 class="title">고객센터</h2>
					
					<!-- 테이블 -->	 
					<div class="table-responsive">
					<table class="table adminList">
					<!-- 제목 -->	 
						<tr>
							<th>분류</th>
							<th class="adminW2">제목</th>
							<th class="adminListDate">작성일</th>
						</tr>
					<!-- 제목 -->	 
					
					<!-- 게시글 -->	 
					<%
					int cnt = pv.getN_noticeCount();//게시글 수
					if(cnt==0){
					%>
						<tr>
							<td colspan="3" class="adminCenter">등록된 게시글이 없습니다.</td>
						</tr>
					<%
					}else{
					for(int i=0;i<qnaList.size();i++){
								  QnaBean qb = (QnaBean) qnaList.get(i);
					%> 
						<tr class="adminH">
							<td><%=qb.getQ_category() %></td>
							<td>
							<%if(qb.getQ_num()>qb.getQ_re_ref()){%>
			 					<!-- 작성자가 관리자일때 답글 이미지 추가-->
								<i class="material-icons">subdirectory_arrow_right</i>
							<%} %>
			 					<a href="./qnaContent.qa?num=<%=qb.getQ_num() %>"> 
			 					<%=qb.getQ_subject() %></a> 
							</td>
			 	    		<td ><%=qb.getQ_date() %></td> 
				    	</tr>
					<!-- 게시글 -->
					<% 
					}}
					%> 
						<tr>
							<td class="adminCenter" colspan="2">
								<!-- 테이블 -->
								<div class="adminRight adminW">
								<!-- 페이징 -->
								<%
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
								
								
								</div>
							</td>
							<%if(!(email.equals("juicetruck.ad@gmail.com"))){ %>
							<!-- 버튼 -->
							<td>
								<div class="col-mr-5 ml-auto mr-auto">
									<input type="button" value="문의하기" class="btn btn-primary" onclick="location.href='./qnaWrite.qa'">
								</div>
							</td>
							<!-- 버튼 -->
							<%}else{ %>
							<td>
								<div class="col-mr-5 ml-auto mr-auto adminHide">
									<input type="button" value="문의하기" class="btn btn-primary" onclick="location.href='./qnaWrite.qa'">
								</div>
							</td>
							<%} %>
						</tr>
						</table>
						</div>
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