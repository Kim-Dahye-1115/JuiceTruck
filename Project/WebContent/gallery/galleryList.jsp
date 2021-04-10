<%@page import="com.portfolio.Gallery.GalleryBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.portfolio.Gallery.GalleryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
 <head>
  <meta charset="UTF-8">
  <title>PORTFOLIO 메인페이지</title>
  <link rel="stylesheet" href="../css/default.css">
 </head>
 
 <body>
  <!-- Header(top) -->
  <jsp:include page="../inc/top.jsp"/>
  <!-- Header(top) -->
  
  <nav>
  <!-- Menubar(left) -->
  <jsp:include page="../inc/leftMenu.jsp"/>
  <!-- Menubar(left) -->
  
  <!-- Center -->
  <div class="center">
  <h1>갤러리</h1>
  <%
    String id = (String) session.getAttribute("id");
  
    GalleryDAO gdao = new GalleryDAO();
    
    int count = gdao.getGalleryListCount();
    int pageSize = 8;
    
    String pageNum = request.getParameter("pageNum");
    if(pageNum == null) pageNum = "1";
    
    int currentPage = Integer.parseInt(pageNum);
    int startRow = (currentPage - 1) * pageSize + 1;
    
    ArrayList gList = null;
    if(count != 0){
   	 gList = gdao.getGalleryList(startRow, pageSize);
   	 System.out.println("pro : 갤러리 목록 저장 완료 !");
    }
    
    GalleryBean gb = new GalleryBean();
  %>
  <label id="count">총 <%=count %>개의 이미지</label>
  <br>
  <section class="center_gallery">
  <%
  if(count != 0){
    for(int i=0;i<gList.size();i++){
    	gb = (GalleryBean) gList.get(i);
  %>
        <img alt="<%=gb.getTag() %>" src="<%=gb.getFile() %>"
        onclick="location.href='detailGalleryForm.jsp?pageNum=<%=pageNum%>&num=<%=gb.getNum() %>'">
  <%
    }} 
  %>
  </section>
  <br>
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
    		 <a href="galleryList.jsp?pageNum=<%=startPage-pageBlock %>">이전</a>
    		 <%
    	 }
    	 
    	 for(int i=startPage;i<=endPage;i++){
    		 %>
    		 <a href="galleryList.jsp?pageNum=<%=i %>"><%=i %></a>
    		 <%
    	 }
    	 
    	 if(endPage < pageCount){
    		 %>
    		 <a href="galleryList.jsp?pageNum=<%=startPage+pageBlock %>">다음</a>
    		 <%
    	 }
     }
  %>
  </section>
  <!-- List Page Number -->
  <br>
  <%
    if(id != null){
  %>
    	<input type="button" value="업로드" name="upload" onclick="location.href='galleryUploadForm.jsp';">
  <%
    }
  %>
  </div>
  <!-- Center -->
  </nav>
  <!-- Footer -->
  <jsp:include page="../inc/bottom.jsp"/>
  <!-- Footer -->
 </body>
</html>