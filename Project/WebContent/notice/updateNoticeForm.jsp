<%@page import="com.portfolio.Notice.NoticeBean"%>
<%@page import="com.portfolio.Notice.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
 <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>PORTFOLIO 공지사항 수정페이지</title>
  <link rel="stylesheet" href="../css/default.css">
  <script type="text/javascript">
    /* 유효성 체크 */
    function check(){
    	var title = document.forms[0].title;
    	
    	if(title.value == ""){
    		alert("제목을 입력하세요.");
    		title.focus();
    		return false;
    	}
    }
  </script>
 </head>
 
 <body>
  <!-- Header -->
  <jsp:include page="../inc/top.jsp"/>
  <!-- Header -->
  <nav>
  <!-- Left -->
  <jsp:include page="../inc/leftMenu.jsp"/>
  <!-- Left -->
  <!-- Center -->
    <%
      request.setCharacterEncoding("utf8");
      String id = (String) session.getAttribute("id");
      if(id == null){
    	  response.sendRedirect("noticeList.jsp");
      }
    %>
    <jsp:useBean id="nb" class="com.portfolio.Notice.NoticeBean"/>
    <jsp:setProperty property="*" name="nb"/>
    <%
      String pageNum = request.getParameter("pageNum");
      nb.setNum(Integer.parseInt(request.getParameter("num")));
      
      NoticeDAO ndao = new NoticeDAO();
      int check = ndao.noticePWcheck(nb.getNum(), id, nb.getPw());
      
      /* 글 존재&비밀번호 일치 : 1 , 글 존재&비밀번호 불일치 : 0 , 글 존재 X : -1 */
      switch(check){
      case 1:
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
    <div class="center">
    <h1>공지사항 수정하기</h1>
 
    <form action="updateNoticePro.jsp?pageNum=<%=pageNum %>&num=<%=nb.getNum() %>" method="post" onsubmit="return check();">
     <table>
      <tr>
       <td>제목</td>
       <td><input type="text" name="title" value="<%=nb.getTitle()%>"></td>
      </tr>
      <tr>
       <td>내용</td>
       <td>
        <textarea rows="10" cols="30" name="content"><%=nb.getContent() %></textarea>
       </td>
      </tr>
     </table>
     <input type="button" value="취소" onclick="history.back();">
     <input type="submit" value="수정">
    </form>
   </div>
  <!-- Center -->
  </nav>
  <!-- Footer -->
  <jsp:include page="../inc/bottom.jsp"/>
  <!-- Footer -->
 </body>
</html>