<%@page import="com.portfolio.Member.MemberBean"%>
<%@page import="com.portfolio.Member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>PORTFOLIO Login Page</title>
 </head>
 
 <body>
  <%
    request.setCharacterEncoding("utf8");

    String id = request.getParameter("id");
    String pw = request.getParameter("pw");
    
    MemberDAO mdao = new MemberDAO();
    int check = mdao.idCheck(id, pw);
    
    /* 아이디 & 비밀번호 체크 */
    /* 아이디 & 비밀번호 O : 1 , 아이디 O & 비밀번호 X : 0 , 아이디 X : -1 */
    switch(check){
    case -1:
    	System.out.println("id check : "+check);
    	%>
    	<script type="text/javascript">
    	  alert("아이디나 비밀번호가 틀렸습니다.");
    	  history.back();
    	</script>
    	<%
    	break;
    case 0:
    	System.out.println("id check : "+check);
    	%>
    	<script type="text/javascript">
    	  alert("아이디나 비밀번호가 틀렸습니다.");
    	  history.back();
    	</script>
    	<%
    	break;
    case 1:
    	session.setAttribute("id", id);
    	%>
    	<script type="text/javascript">
    	  alert("로그인 성공");
    	  location.href="../main/main.jsp";
    	</script>
    	<%
    	break;
    }
  %>
 </body>
</html>