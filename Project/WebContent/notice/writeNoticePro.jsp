<%@page import="com.portfolio.Notice.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>공지사항 작성</title>
 </head>
 
 <body>
  <%
    request.setCharacterEncoding("utf8");
  %>
  <jsp:useBean id="nb" class="com.portfolio.Notice.NoticeBean"/>
  <jsp:setProperty property="*" name="nb"/>
  <%
    NoticeDAO ndao = new NoticeDAO();
    ndao.insertNotice(nb);
    response.sendRedirect("noticeList.jsp");
  %>
 </body>
</html>