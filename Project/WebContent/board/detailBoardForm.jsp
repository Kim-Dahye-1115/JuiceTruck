<%@page import="com.portfolio.Board.BoardBean"%>
<%@page import="com.portfolio.Board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
 <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>PORTFOLIO 게시판 상세페이지</title>
  <link rel="stylesheet" href="../css/default.css">
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
      String pageNum = request.getParameter("pageNum");
      int num = Integer.parseInt(request.getParameter("num"));
      
      BoardDAO bdao = new BoardDAO();
      bdao.updateReadcount(num);	//조회수 증가
      BoardBean bb = bdao.getBoard(num);

      //content enter key 값 부여
      String content = bb.getContent();
   	  if(content != null) content.replace("\r\n", "<br>");
    %>
    
   <script type="text/javascript">
   function check(index){
   	var pw = document.forms[0].pw;

	if(pw.value == "" || pw.value.length < 4){
		alert("비밀번호를 입력하세요.");
		pw.focus();
		return false;
	}
	
	/* submit button check
    index => 0 : 삭제  , 1 : 수정*/
   	if(index == 0){	//삭제
		var result = confirm("정말 삭제하시겠습니까?");
		if(result){
			document.forms[0].action='deleteBoardPro.jsp?pageNum=<%=pageNum%>&num=<%=num%>';
		}
	}
	if(index == 1){	//수정
		document.forms[0].action='updateBoardForm.jsp?pageNum=<%=pageNum%>&num=<%=num%>';
	}
   }
   </script>
   <div class="center">
    <h1>게시판 상세페이지</h1>
 
    <form method="post" >
     <table>
	  <tr>
	   <td rowspan="2"><input type="text" name="title" id="txt_readonly" value="<%=bb.getTitle()%>" readonly></td>
	   <td>작성일</td>
	   <td>조회</td>
	  </tr>
	  <tr>
	   <td><%=bb.getDate() %></td>
	   <td><%=bb.getReadcount() %></td>
	  </tr>
	  <tr>
	   <td colspan="3">
	    <textarea rows="10" cols="30" name="content" id="txt_readonly" readonly><%=bb.getContent() %></textarea>
	   </td>
	  </tr>
     </table>
    
    <!-- 로그인시에만 수정/삭제 버튼 보여주기 -->
    <%
     if(id != null){
    	 if(id.equals(bb.getId())){
    %>
      <label>글 비밀번호 <input type="password" name="pw" placeholder="숫자 4자리 " maxlength="4"></label>
      <input type="submit" value="삭제" onclick="check(0);">
      <input type="submit" value="수정" onclick="check(1);">
    <%
      }  
    %>
      <input type="button" value="답글"
      	onclick="location.href='reWriteForm.jsp?num=<%=num%>&pageNum=<%=pageNum %>&re_ref=<%=bb.getRe_ref() %>&re_lev=<%=bb.getRe_lev() %>&re_seq=<%=bb.getRe_seq() %>';">
    <%
     }
    %>
     <!-- 로그인시에만 수정/삭제 버튼 보여주기 -->
   
     <input type="button" value="목록" onclick="location.href='boardList.jsp?pageNum=<%=pageNum %>';">
    </form>
   </div>
  <!-- Center -->
  </nav>
  <!-- Footer -->
  <jsp:include page="../inc/bottom.jsp"/>
  <!-- Footer -->
 </body>
</html>