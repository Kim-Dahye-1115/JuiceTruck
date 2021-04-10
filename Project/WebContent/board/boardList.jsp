<%@page import="com.portfolio.Board.BoardDAO"%>
<%@page import="com.portfolio.Board.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
 <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>PORTFOLOIO 게시판</title>
  <link rel="stylesheet" href="../css/default.css">
 </head>
 
 <body>
  <!-- Header -->
  <jsp:include page="../inc/top.jsp"/>
  <!-- Header -->
  
  <nav>
  <!-- Left -->
  <jsp:include page="../inc/leftMenu.jsp"/>
  <!-- Left -->
  <!-- Center -->
   <div class="center">
   <h1>게시판 목록</h1>
   <!-- DB에서 Board List 가져오기 -->
   <%
     String id = (String) session.getAttribute("id");
     
     BoardBean bb = new BoardBean();
     
     BoardDAO bdao = new BoardDAO();
     
     int count = bdao.getBoardListCount();
     int pageSize = 10;
     
     String pageNum = request.getParameter("pageNum");
     if(pageNum == null) pageNum = "1";
     
     int currentPage = Integer.parseInt(pageNum);
     int startRow = (currentPage - 1) * pageSize + 1;
     
     ArrayList bList = null;
     if(count != 0){
    	 bList = bdao.getBoardList(startRow, pageSize);
    	 System.out.println("pro : 게시판 목록 저장 완료 !");
     }
   %>
   <!-- DB에서 Board List 가져오기 -->
   <label id="count">총 <%=count %>개 글</label>
   
   <!-- Table에 가져온 List 보여주기 -->
   <section class="center_board">
     <table>
      <tr>
       <td>번호</td>
       <td>게시글</td>
       <td>조회수</td>
       <td>이미지</td>
      </tr>
      <%
      if(count != 0){
        for(int i=0;i<bList.size();i++){
        	bb = (BoardBean) bList.get(i);
      %>
     <tr>
      <td rowspan="3"><%=bb.getNum() %></td>
      <td id="title">
        <%
		  int wid = 0;
		  if(bb.getRe_lev() != 0){
		   wid = 10*bb.getRe_lev();
		%>
		   <img src="../img/re.gif" height="10" width="<%=wid %>">
		   <img src="../img/level.gif" height="10">
		<%
		  }
		%>
        <a href="detailBoardForm.jsp?pageNum=<%=pageNum %>&num=<%=bb.getNum() %>">
        <%=bb.getTitle() %></a>
      </td>
      <td id="content"><%=bb.getReadcount() %></td>
      <td rowspan="3"><img id="img" alt="게시판 이미지" src="../img/box.jpg"></td>
     </tr>
     <tr>
      <td id="content" colspan="2"><%=bb.getContent() %></td>
     </tr>
     <tr>
      <td id="write" colspan="2"><%=bb.getId() %> | <%=bb.getDate() %></td>
     </tr>
    <%
      }}
    %>
   </table>
   </section>
   <!-- Table에 가져온 List 보여주기 -->
   
   <!-- List Page Number -->
   <section class="page_num">
   <%
     if(count != 0){
    	 int pageCount = count/pageSize+(count%pageSize==0? 0:1);
    	 int pageBlock = 5;
    	 int startPage = ((currentPage-1)/pageBlock)*pageBlock+1;
    	 int endPage = startPage+pageBlock-1;
    	 
    	 if(endPage > pageCount){
    		 endPage = pageCount;
    	 }
    	 
    	 if(startPage > pageBlock){
    		 %>
    		 <a href="boardList.jsp?pageNum=<%=startPage-pageBlock %>">이전</a>
    		 <%
    	 }
    	 
    	 for(int i=startPage;i<=endPage;i++){
    		 %>
    		 <a href="boardList.jsp?pageNum=<%=i %>"><%=i %></a>
    		 <%
    	 }
    	 
    	 if(endPage < pageCount){
    		 %>
    		 <a href="boardList.jsp?pageNum=<%=startPage+pageBlock %>">다음</a>
    		 <%
    	 }
     }
   %>
   </section>
   <!-- List Page Number -->
   
   <!-- 로그인시에만 글쓰기 버튼 보여주기 -->
   <%
     if(id != null){
   %>
     <input type="button" value="작성" onclick="location.href='writeBoardForm.jsp?id=<%=id%>'">
   <%
     }
   %>
   <!-- 로그인시에만 글쓰기 버튼 보여주기 -->
   </div>
  <!-- Center -->
  </nav>
  <!-- Footer -->
  <jsp:include page="../inc/bottom.jsp"/>
  <!-- Footer -->
 </body>
</html>