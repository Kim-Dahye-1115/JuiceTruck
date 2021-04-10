<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
 <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>PORTFOLIO 공지사항 작성페이지</title>
  <link rel="stylesheet" href="../css/default.css">
  <script type="text/javascript">
    /* 유효성 체크 */
    function check(){
    	var title = document.forms[0].title;
    	var pw = document.forms[0].pw;
    	
    	if(title.value == ""){
    		alert("제목을 입력하세요.");
    		title.focus();
    		return false;
    	}
    	if(pw.value == "" || pw.value.length < 4){
    		alert("비밀번호를 입력하세요.");
    		pw.focus();
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
      String id = (String) session.getAttribute("id");
      if(id == null){
    	  response.sendRedirect("noticeList.jsp");
      }
    %>
   <div class="center">
    <h1>공지사항 작성하기</h1>
 
    <form action="writeNoticePro.jsp?id=<%=id %>" method="post" onsubmit="return check();">
     <table>
      <tr>
       <td>제목</td>
       <td><input type="text" name="title" placeholder="제목을 입력하세요"></td>
      </tr>
      <tr>
       <td>내용</td>
       <td>
        <textarea rows="10" cols="30" name="content" placeholder="내용을 입력하세요."></textarea> 
       </td>
      </tr>
     </table>
     <label>글 비밀번호 <input type="password" name="pw" placeholder="숫자 4자리 " maxlength="4"></label>
     <input type="button" value="취소" onclick="history.back();">
     <input type="submit" value="작성">
    </form>
   </div>
  <!-- Center -->
  </nav>
  <!-- Footer -->
  <jsp:include page="../inc/bottom.jsp"/>
  <!-- Footer -->
 </body>
</html>