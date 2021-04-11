<%@page import="com.admin.action.pagingVO"%>
<%@page import="java.io.Console"%>
<%@page import="com.market.db.ReviewBean"%>
<%@page import="com.market.db.ReviewDAO"%>
<%@page import="java.util.ArrayList"%>
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
		
		<h2> 리뷰 리스트 페이지 </h2>
			<%
			  // s_nick 가져오기 - 수정한 부분
			  String s_nick = request.getParameter("s_nick");
			  // s_nick 가져오기  - 수정한 부분
			  
			  String w_nick = (String) session.getAttribute("nick");
			  List<ReviewBean> reviewList = (List<ReviewBean>)request.getAttribute("reviewList");
			  
			  // 페이징 처리 객체 가져오기 - 수정한 부분
			  pagingVO pv = (pagingVO)request.getAttribute("pv");
			  // 페이징 처리 객체 가져오기 - 수정한 부분
			  
			  // DAO 객체 생성
			  ReviewDAO rdao = new ReviewDAO();
			  
			%>
		   
		   <table border="1">
		   <%
		   		/* 리뷰리스트 불러와서 BEAN에 담기 */
		   		//if(cnt != 0){
		   		for(int i=0;i<reviewList.size();i++){
		   			ReviewBean rb = (ReviewBean)reviewList.get(i);
		   %>
					    <tr>
					      <td>별점</td>
					      <td>
					        <%for(int j=1;j<=rb.getRe_star();j++){ %>
					          <i class="material-icons">star</i>
					        <%
					          }
					        %>
					        <%for(int j=1;j<=(5-rb.getRe_star());j++){ %>
					          <i class="material-icons">star_outline</i>
					        <%
					          }
					        %>
					      </td>
					    </tr>
					    <tr>
						  <td>
						    <!-- 회원이미지 -->
						    <img alt="회원이미지" src="">
						  </td>
						  <!-- 판매자 닉네임 -->
						  <td><%=rb.getS_nick() %></td>
						   
					    </tr>
					    <tr>
					      <td>
					        <!-- 회원이미지 -->
					        <img alt="회원이미지" src="">
					      </td>
					      <!-- 작성자 닉네임 -->
						  <td><%=rb.getW_nick() %></td>
					    </tr>
					    <tr>
					      <td>리뷰내용</td>
						  <td><%=rb.getRe_content() %></td>
						   
						  <!-- 등록된 이미지 파일  -->
					    </tr>
						<%if(rb.getFile() != null){ %>
					    <tr>
						  <!-- 이미지 파일 -->
						  <td>첨부 파일</td>
						  <td>
						    <img src="./upload/<%=rb.getFile()%>">
						  </td>
					    </tr>
						<%
						  }
						%>
					    <tr>
					      <td colspan="2">
					        <!-- 리뷰 등록날짜 -->
					        <%=rb.getRe_date() %>
					      </td>
					    </tr>
						<%if(w_nick.equals(rb.getW_nick())){%>
						<tr>
						  <td colspan="2">
						    <a href="./reviewUpdate.re?num=<%=rb.getRe_num() %>">리뷰 수정</a>
							<a href="./reviewDelete.re?num=<%=rb.getRe_num() %>">리뷰 삭제</a>
						  </td>
						</tr>
					    <%
					      }
						%>
		    <%	} %>
			   </table>
			   
			   
			<!-- 페이징 처리 - 수정한 부분 -->
			   <div id="page_control">
			<%
			System.out.println("view : s_nick - "+s_nick);
			int cnt = rdao.getReviewCount(s_nick, w_nick);
			int pageBlock = pv.getN_pageBlock();
			int pageNum = pv.getN_pageNum();
			int pageSize = pv.getN_pageSize();
			if(pv.getN_noticeCount() != 0){
				  // 전체 페이지 수 계산하기
				  int pageCount = cnt/pageSize+(cnt%pageSize==0? 0:1);
				  // 한 페이지에서 시작하는 페이지 번호
				  int startPage = ((pageNum-1)/pageBlock)*pageBlock+1;
				  // 한 페이지에서 끝나는 페이지 번호
				  int endPage = startPage+pageBlock-1;
				  
				  if(endPage > pageCount){
					  endPage = pageCount;
				  }
				  
				  //이전페이지 활성화
				  if(startPage > pageBlock){
				%>
					<%if(s_nick != null){%>
					<a href="./reviewList.re?pageNum=<%=startPage-pageBlock%>&s_nick=<%=s_nick%>">이전</a>
					<%}else{ %>
					<a href="./reviewList.re?pageNum=<%=startPage-pageBlock%>">이전</a>
					<%} %>
				<%
				  }
				  for(int i=startPage; i<=endPage; i++){ 
				%>
					<%if(s_nick != null){%>
					<a href="./reviewList.re?pageNum=<%=i%>&s_nick=<%=s_nick%>"><%=i %></a>
					<%}else{ %>
					<a href="./reviewList.re?pageNum=<%=i%>"><%=i %></a>
					<%} %>
				<%
				  }
				  // 다음페이지 활성화
				  if(endPage < pageCount){
				%>
					<%if(s_nick != null){%>
					<a href="./reviewList.re?pageNum=<%=startPage-pageBlock%>&s_nick=<%=s_nick%>">다음</a>
					<%}else{ %>
					<a href="./reviewList.re?pageNum=<%=startPage-pageBlock%>">다음</a>
					<%} %>
				<%
				  }
			}
				%>
				
			</div>
			<!-- 페이징 처리 - 수정한 부분 -->
		
		<!-- 푸터 -->
		<jsp:include page="../inc/bottom.jsp"/>
		<!-- 푸터 -->
	</body>
</html>