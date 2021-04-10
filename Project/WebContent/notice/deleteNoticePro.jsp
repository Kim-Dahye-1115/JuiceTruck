<%@page import="com.portfolio.Notice.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>공지사항 삭제</title>
 </head>
 
 <body>
  <%
    request.setCharacterEncoding("utf8");
  
    String id = (String) session.getAttribute("id");
    if(id == null){
	  response.sendRedirect("noticeList.jsp");
    }
    
    int num = Integer.parseInt(request.getParameter("num"));
    String pw = request.getParameter("pw");
    
    NoticeDAO ndao = new NoticeDAO();
    int check = ndao.noticePWcheck(num, id, pw);
  
    /* 글 존재&비밀번호 일치 : 1 , 글 존재&비밀번호 불일치 : 0 , 글 존재 X : -1 */
    switch(check){
    case 1:
    	ndao.deleteNotice(num);
    	%>
	  	<script type="text/javascript">
	  	 alert("공지사항이 삭제되었습니다.");
	  	 location.href="noticeList.jsp";
	  	</script>
	  	<%
  		break;
    case 0:
	  	%>
	  	<script type="text/javascript">
	  	 alert("비밀번호를 확인 해주세요.");
	  	 history.back();
	  	</script>
	  	<%
  		break;
    case -1:
	  	%>
	  	<script type="text/javascript">
	  	 alert("글이 존재하지 않습니다.");
	  	 history.back();
	  	</script>
	  	<%
	  	break;
    }
  %>
 </body>
</html>