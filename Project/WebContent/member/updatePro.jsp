<%@page import="com.portfolio.Member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>PORTFOLIO update page</title>
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
   
    int check = -1;
    int idcheck = -1;
    
    if(mb.getNick() == null){
    	check = mdao.updateOverlapCheck(mb.getId(), mb.getEmail());
    } else{
    	check = mdao.updateOverlapCheck(mb.getId(), mb.getEmail(), mb.getNick());
    }
    
    /* 이메일, 닉네임 중복 체크 - 시작
       -2 : 닉네임 중복 , -1 : 아이디 X , 0 : 이메일 중복 , 1 : 이메일&닉네임 중복 X */
    System.out.println("overlap check : "+check);
    switch(check){
    case 1:
       	idcheck = mdao.updateMember(mb);
    	break;
    case 0:
           %>
           <script type="text/javascript">
           	alert("이메일이 이미 존재합니다.");
           	history.back();
           </script>
           <%
     	break;
     case -1:
           %>
           <script type="text/javascript">
           	alert("아이디가 이미 존재합니다.");
           	history.back();
           </script>
           <%
     	break;
     case -2:
       	System.out.println("nick check : "+check);
           %>
           <script type="text/javascript">
           	alert("닉네임이 이미 존재합니다.");
           	history.back();
           </script>
           <%
     	break;
     }
    /* 이메일, 닉네임 중복 체크 - 끝 */
    
    /* 아이디 & 비밀번호 일치 체크 */
    System.out.println("id check : "+idcheck);
    switch(idcheck){
    case -1:
    	%>
    	<script type="text/javascript">
    	  alert("아이디나 비밀번호가 틀렸습니다.");
    	  history.back();
    	</script>
    	<%
    	break;
    case 0:
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
    	  alert("회원 정보 수정 성공");
    	  location.href="../main/main.jsp";
    	</script>
    	<%
    	break;
    }
    /* 아이디 & 비밀번호 일치 체크 */
   %>
 </body>
</html>