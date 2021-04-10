<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<header>
 <div class="top_logo">
  PORTFOLIO
 </div>
 <!-- 로그인 컨트롤 -->
 <%
   String id = (String) session.getAttribute("id");
   if(id == null){
 %>
 <div class="top_btn_login">
  <input type="button" value="로그인" onclick="location.href='../member/loginForm.jsp'">
 </div>
 <%
   } else{
 %>
 <div class="top_btn_logout">
  <input type="button" value="마이페이지" onclick="location.href='../member/myForm.jsp'">
  <input type="button" value="로그아웃" onclick="location.href='../member/logout.jsp'">
 </div>
 <%
   } 
 %>
 <!-- 로그인 컨트롤  -->
</header>