<%@page import="com.portfolio.Member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>PORTFOLIO join page</title>
 </head>
 
 <body>
  <%
    request.setCharacterEncoding("utf8");
  %>
    <jsp:useBean id="mb" class="com.portfolio.Member.MemberBean"/>
    <jsp:setProperty property="*" name="mb"/>
  <%
    System.out.println(mb);
    MemberDAO mdao = new MemberDAO();
  
    int check = -1;
    
    if(mb.getNick() == null){
    	check = mdao.overlapCheck(mb.getId(), mb.getEmail());
    } else{
    	check = mdao.overlapCheck(mb.getId(), mb.getEmail(), mb.getNick());
    }
    
    /* 아이디,이메일,닉네임 중복 체크 - 시작 */
    switch(check){
    case 1:	//아이디와 이메일 중복 X - insert member
    	System.out.println("id&email check : "+check);
    	mdao.insertMember(mb);
    	response.sendRedirect("../main/main.jsp");
    	break;
    case 0:		//이메일 중복
    	System.out.println("id&email check : "+check);
        %>
        <script type="text/javascript">
        	alert("이메일이 이미 존재합니다.");
        	history.back();
        </script>
        <%
    	break;
    case -1:		//아이디 중복
    	System.out.println("id&email check : "+check);
        %>
        <script type="text/javascript">
        	alert("아이디가 이미 존재합니다.");
        	history.back();
        </script>
        <%
    	break;
    case -2:		//닉네임 중복
    	System.out.println("nick check : "+check);
        %>
        <script type="text/javascript">
        	alert("닉네임이 이미 존재합니다.");
        	history.back();
        </script>
        <%
    	break;
    }
    /* 아이디,이메일,닉네임 중복 체크 - 끝 */
    
  %>
 </body>
</html>