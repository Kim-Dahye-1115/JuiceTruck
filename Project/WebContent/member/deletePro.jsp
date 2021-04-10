<%@page import="com.portfolio.Member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>PORTFOLIO delete page</title>
 </head>

 <body>
  <%
    request.setCharacterEncoding("utf8");

    String id = (String) session.getAttribute("id");
    if(id == null){
    	response.sendRedirect("loginForm.jsp");
    }
   %>
     <jsp:useBean id="mb" class="com.portfolio.Member.MemberBean"/>
     <jsp:setProperty property="*" name="mb"/>
   <%
    MemberDAO mdao = new MemberDAO();
    int check = mdao.deleteMember(id, mb.getPw());
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
    	session.invalidate();
    	%>
    	<script type="text/javascript">
    	  alert("회원 탈퇴 되었습니다.");
    	  location.href="../main/main.jsp";
    	</script>
    	<%
    	break;
    }
   %>
 </body>
</html>