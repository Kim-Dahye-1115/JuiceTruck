<%@page import="com.portfolio.Board.BoardBean"%>
<%@page import="com.portfolio.Notice.NoticeBean"%>
<%@page import="com.portfolio.Gallery.GalleryBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.portfolio.main.MainDAO"%>
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
  
  <!-- Main contents load -->
  <%
    MainDAO mdao = new MainDAO();
    GalleryBean gb = new GalleryBean();
    NoticeBean nb = new NoticeBean();
    BoardBean bb = new BoardBean();
    
    ArrayList galleryList = mdao.getGalleryList();
    ArrayList noticeList = mdao.getNoticeList();
    ArrayList boardList = mdao.getBoardList();
  %>
  <!-- Main contents load -->
  
  <nav>
  <!-- Menubar(left) -->
  <jsp:include page="../inc/leftMenu.jsp"/>
  <!-- Menubar(left) -->
  
  <!-- Content(center) -->
  <div class="center">
  <hr>
  <section class="center_notice">
   <a href="../notice/noticeList.jsp">공지사항</a><br>
  <%
    for(int i=0;i<noticeList.size();i++){
      nb = (NoticeBean) noticeList.get(i);
  %>
    <a href="../notice/detailNoticeForm.jsp?num=<%=nb.getNum()%>"><%=nb.getTitle() %></a><br>
  <%
    }
  %>
  </section>
  <hr>
  갤러리<br>
  <section class="center_gallery">
  <%
    for(int i=0;i<galleryList.size();i++){
  	  gb = (GalleryBean) galleryList.get(i);
  %>
   <img alt="<%=i %>" src="<%=gb.getFile()%>" onclick="location.href='../gallery/detailGalleryForm.jsp?num=<%=gb.getNum()%>'">
  <%
    }
  %>
   <input type="button" value="더 보기" onclick="location.href='../gallery/galleryList.jsp'">
  </section>
  <hr>
  게시판<br>
  <section class="center_board">
  <%
    for(int i=0;i<boardList.size();i++){
  	  bb = (BoardBean) boardList.get(i);
  %>
   <table>
     <tr>
      <td>
        <a href="../board/detailBoardForm.jsp?num=<%=bb.getNum() %>">
        <%=bb.getTitle() %></a></td>
      <td rowspan="3"><img id="img" alt="게시판 이미지" src="../img/box.jpg"></td>
     </tr>
     <tr>
      <td id="content"><%=bb.getContent() %></td>
     </tr>
     <tr>
      <td id="write"><%=bb.getId() %> | <%=bb.getDate() %></td>
     </tr>
   </table>
  <%
    }
  %>
   <input type="button" value="더보기" onclick="location.href='../board/boardList.jsp'">
  </section>
  </div>
  <!-- Content(center) -->
  </nav>
  <!-- Footer -->
  <jsp:include page="../inc/bottom.jsp"/>
  <!-- Footer -->
 </body>
</html>