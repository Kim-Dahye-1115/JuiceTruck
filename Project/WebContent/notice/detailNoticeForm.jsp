<%@page import="com.portfolio.Notice.NoticeBean"%>
<%@page import="com.portfolio.Notice.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
 <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>PORTFOLIO 공지사항 상세페이지</title>
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
      
      NoticeDAO ndao = new NoticeDAO();
      ndao.updateReadcount(num);	//조회수 증가
      NoticeBean nb = ndao.getNotice(num);

      //content enter key 값 부여
      String content = nb.getContent();
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
			document.forms[0].action='deleteNoticePro.jsp?pageNum=<%=pageNum%>&num=<%=num%>';
		}
	}
	if(index == 1){	//수정
		document.forms[0].action='updateNoticeForm.jsp?pageNum=<%=pageNum%>&num=<%=num%>';
	}
   }
   </script>
   <div class="center">
    <h1>공지사항</h1>
 
    <form method="post" >
     <table>
	  <tr>
	   <td rowspan="2"><input type="text" name="title" id="txt_readonly" value="<%=nb.getTitle()%>" readonly></td>
	   <td>작성일</td>
	   <td>조회</td>
	  </tr>
	  <tr>
	   <td><%=nb.getDate() %></td>
	   <td><%=nb.getReadcount() %></td>
	  </tr>
	  <tr>
	   <td colspan="3">
	    <textarea rows="10" cols="30" name="content" id="txt_readonly" readonly><%=nb.getContent() %></textarea>
	   </td>
	  </tr>
     </table>
    
    <!-- 관리자 계정만 수정/삭제 버튼 보여주기 -->
    <%
     if(id != null && id.equals("admin")){
    %>
      <label>글 비밀번호 <input type="password" name="pw" placeholder="숫자 4자리 " maxlength="4"></label>
      <input type="submit" value="삭제" onclick="check(0);">
      <input type="submit" value="수정" onclick="check(1);">
    <%
     }
    %>
     <!-- 관리자 계정에서만 수정/삭제 버튼 보여주기 -->
   
     <input type="button" value="목록" onclick="location.href='noticeList.jsp?pageNum=<%=pageNum %>'">
    </form>
   </div>
  <!-- Center -->
  </nav>
  <!-- Footer -->
  <jsp:include page="../inc/bottom.jsp"/>
  <!-- Footer -->
 </body>
</html>