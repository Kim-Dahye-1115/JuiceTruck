<%@page import="com.portfolio.Board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>게시판 작성</title>
 </head>
 
 <body>
  <%
    request.setCharacterEncoding("utf8");
  %>
  <jsp:useBean id="bb" class="com.portfolio.Board.BoardBean"/>
  <jsp:setProperty property="*" name="bb"/>
  <%
    BoardDAO bdao = new BoardDAO();
    bdao.insertBoard(bb);
    response.sendRedirect("boardList.jsp");
  %>
 </body>
</html>