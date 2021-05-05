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
<script type="text/javascript">
	function del() {
		var check = confirm("삭제하시겠습니까?");
		if(check){
		location.href='./noticeDelete.no?num=<%=nb.getN_num()%>'
		}
	}
</script>		
<div class="main main-raised">
	<div class="container">
		<div class="section section-text">
			<div class="row">
 				<div class="col-md-9 ml-auto mr-auto"> 	
 						
					<h3 class="title">공지사항</h3>
					
					<!-- 테이블 -->
					<div class="table-responsive">
						<table class="table adminList">
							<tr>
								<th><%=nb.getN_title() %></th>
								<td class="adminW4"><%=nb.getN_date() %></td>
								<td class="adminW4">조회<%=nb.getN_read_count() %></td>
							</tr>
							<tr>
								<td colspan="3"><%=nb.getN_content() %></td>
							</tr>
						</table>
					</div>						
					<!-- 테이블 -->
									
					<!-- 버튼 -->
						<!-- 관리자일떄-->
						<%if(email.equals("juicetruck.ad@gmail.com")){ %>
						<div class="col-md-4 ml-auto mr-auto fileadd6">
							<button onclick="del();" class="btn btn-primary">삭제</button>
						<%}else{ %>
						<div class="col-md-2 ml-auto mr-auto fileadd6">
						<%} %>
							<button onclick="location.href='./noticeList.no?pageNum=<%=pageNum%>'" class="btn btn-primary">목록</button>
					</div>
					<!-- 버튼 -->
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