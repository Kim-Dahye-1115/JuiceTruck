<!-- 
공지사항 리스트 페이지
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
		
		<%
			String email = (String) session.getAttribute("email");
			List noticeList = (List) request.getAttribute("noticeList");
			pagingVO pv = (pagingVO) request.getAttribute("pagingVO");
		%>
<div class="main main-raised">
	<div class="container">
		<div class="section section-text">
			<div class="row">
 				<div class="col-md-9 ml-auto mr-auto"> 		
					<h2 class="title">공지사항</h2>
					<!-- 테이블 -->
					<!-- <div class="row"> -->
					 <div class="table-responsive">
					 <!-- 여기클래스만 변경하면 됨 -->
						<table class="table adminList" >
							<tr>
								<th>번호</th>
								<th class="adminW">제목</th>
								<th class="adminListDate">작성일</th>
								<th>조회</th>
							</tr>
							<%
							int cnt = pv.getN_noticeCount();//게시글 수
							if(cnt==0){
							%>
								<tr>
									<td colspan="4" class="adminCenter">등록된 게시글이 없습니다.</td>
								</tr>
							<%
							}else{
							for(int i=0; i<noticeList.size();i++){
								NoticeBean nb = (NoticeBean)noticeList.get(i);
							%>
								<tr class="adminH">
									<td><%=nb.getN_num() %></td>
									<td><a href="./noticeContent.no?num=<%=nb.getN_num()%>&pageNum=<%=pv.getN_pageNum()%>"><%=nb.getN_title() %></a></td>
									<td><%=nb.getN_date() %></td>
									<td><%=nb.getN_read_count() %></td>
								</tr>
							<%
							}}
							%>
							<tr>
								<td class="adminCenter" colspan="2">
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
									</div>
								</td>
								<td colspan="2">
									<!-- 관리자일때  -->
									<div class="col-md-5 ml-auto mr-auto">
									<%if(email.equals("juicetruck.ad@gmail.com")) {%>
									<!-- 버튼 -->
										<button class="btn btn-primary" onclick="location.href='./noticeWrite.no'">글쓰기</button>
									<!-- 버튼 -->
									<%}else{ %>
										<button class="adminHide" onclick="location.href='./noticeWrite.no'">글쓰기</button>
									<%} %>
									</div> 
								</td>
							</tr>
						</table>
					<!-- 테이블 -->
					</div>
					
					<!-- 검색창 -->
					<div class="col-md-11 ml-auto mr-auto">
						<form class="text-center" action="./noticeList.no" method="get">
							<input type="text" class="form-control" name="search" placeholder="공지사항 검색">
							<button type="submit" class="btn btn-primary btn-link search">
								<i class="material-icons searchicon">search</i></button>
					<!-- 검색창 -->
						</form>
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