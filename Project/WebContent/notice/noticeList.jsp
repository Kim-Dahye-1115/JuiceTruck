<%@page import="com.portfolio.Notice.NoticeBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.portfolio.Notice.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
 <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>PORTFOLOIO 공지사항</title>
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
   <h1>공지사항 목록</h1>
   <!-- DB에서 Notice List 가져오기 -->
   <%
     String id = (String) session.getAttribute("id");
     
     NoticeBean nb = new NoticeBean();
     
     NoticeDAO ndao = new NoticeDAO();
     
     int count = ndao.getNoticeListCount();
     int pageSize = 10;
     
     String pageNum = request.getParameter("pageNum");
     if(pageNum == null) pageNum = "1";
     
     int currentPage = Integer.parseInt(pageNum);
     int startRow = (currentPage - 1) * pageSize + 1;
     
     ArrayList nList = null;
     if(count != 0){
    	 nList = ndao.getNoticeList(startRow, pageSize);
    	 System.out.println("pro : 공지사항 목록 저장 완료 !");
     }
   %>
   <!-- DB에서 Notice List 가져오기 -->
   <label id="count">총 <%=count %>개 글</label>
   
   <!-- Table에 가져온 List 보여주기 -->
   <section class="center_board">
     <table>
      <tr>
       <td>번호</td>
       <td>제목</td>
       <td>작성일</td>
       <td>조회</td>
      </tr>
      <%
      if(count != 0){
        for(int i=0;i<nList.size();i++){
        	nb = (NoticeBean) nList.get(i);
      %>
      <tr>
       <td><%=nb.getNum() %></td>
       <td>
       	<a href="detailNoticeForm.jsp?pageNum=<%=pageNum %>&num=<%=nb.getNum() %>">
       	<%=nb.getTitle() %></a>
       </td>
       <td><%=nb.getDate() %></td>
       <td><%=nb.getReadcount() %></td>
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
    		 <a href="noticeList.jsp?pageNum=<%=startPage-pageBlock %>">이전</a>
    		 <%
    	 }
    	 
    	 for(int i=startPage;i<=endPage;i++){
    		 %>
    		 <a href="noticeList.jsp?pageNum=<%=i %>"><%=i %></a>
    		 <%
    	 }
    	 
    	 if(endPage < pageCount){
    		 %>
    		 <a href="noticeList.jsp?pageNum=<%=startPage+pageBlock %>">다음</a>
    		 <%
    	 }
     }
   %>
   </section>
   <!-- List Page Number -->
   
   <!-- 관리자 계정만 글쓰기 버튼 보여주기 -->
   <%
     if(id != null && id.equals("admin")){
   %>
     <input type="button" value="작성" onclick="location.href='writeNoticeForm.jsp?id=<%=id%>'">
   <%
     }
   %>
   <!-- 관리자 계정에서만 글쓰기 버튼 보여주기 -->
   </div>
  <!-- Center -->
  </nav>
  <!-- Footer -->
  <jsp:include page="../inc/bottom.jsp"/>
  <!-- Footer -->
 </body>
</html>