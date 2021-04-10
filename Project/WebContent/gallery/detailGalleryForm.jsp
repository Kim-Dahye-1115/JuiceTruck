<%@page import="com.portfolio.Gallery.GalleryBean"%>
<%@page import="com.portfolio.Gallery.GalleryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
 <head>
  <meta charset="UTF-8">
  <title>PORTFOLIO 갤러리 상세페이지</title>
  <link rel="stylesheet" href="../css/default.css">
 </head>
 
 <body>
  <!-- Header(top) -->
  <jsp:include page="../inc/top.jsp"/>
  <!-- Header(top) -->

  <nav>
  <!-- Menubar(left) -->
  <jsp:include page="../inc/leftMenu.jsp"/>
  <!-- Menubar(left) -->
  
  <!-- Center -->
    <%
      String id = (String) session.getAttribute("id");
      String pageNum = request.getParameter("pageNum");
      int num = Integer.parseInt(request.getParameter("num"));
      
      GalleryDAO gdao = new GalleryDAO();
      gdao.updateReadcount(num);	//조회수 증가
      GalleryBean gb = gdao.getGallery(num);
      
      if(gb.getTag() == null) gb.setTag("");
    %>
    
   <script type="text/javascript">
   function check(index){
	/* submit button check
    index => 0 : 삭제  , 1 : 수정*/
   	if(index == 0){	//삭제
		var result = confirm("정말 삭제하시겠습니까?");
		if(result){
			document.forms[0].action='deleteGalleryPro.jsp?pageNum=<%=pageNum%>&num=<%=num%>';
		}
	}
   	if(index == 1){	//태그 수정
   		document.forms[0].action='updateGalleryTagPro.jsp?pageNum=<%=pageNum%>&num=<%=num%>';
	}
   }
   </script>
   <section class="center">
   <h1>갤러리 상세페이지</h1>
   <form method="post" class="center_gallery">
     <table>
	  <tr>
	   <td>아이디</td>
	   <td>작성일</td>
	   <td>조회</td>
	  </tr>
	  <tr>
	   <td><input type="text" name="id" id="txt_readonly" value="<%=gb.getId()%>" readonly></td>
	   <td><%=gb.getDate() %></td>
	   <td><%=gb.getReadcount() %></td>
	  </tr>
	  <tr>
	   <td colspan="3">
	     <img alt="" src="<%=gb.getFile() %>">
	   </td>
	  </tr>
	  <tr>
	   <td>태그</td>
	   <td colspan="2">
	     <input type="text" name="tag" id="txt_readonly" value="<%=gb.getTag()%>" readonly>
	   </td>
	  </tr>
	<%
     if(id != null && id.equals(gb.getId())){
    %>
	  <tr>
       <td>태그 수정</td>
       <td>
        <label><input type="checkbox" name="re_tag" value="1">1</label>
        <label><input type="checkbox" name="re_tag" value="2">2</label>
        <label><input type="checkbox" name="re_tag" value="3">3</label>
        <label><input type="checkbox" name="re_tag" value="4">4</label>
       </td>
      </tr>
    <%
     }
    %>
    </table>
    
    <!-- 로그인 시에만 수정/삭제 버튼 보여주기 -->
    <%
     if(id != null && id.equals(gb.getId())){
    %>
      <input type="submit" value="삭제" onclick="check(0);">
      <input type="submit" value="태그 수정" onclick="check(1);">
    <%
     }
    %>
     <!-- 로그인 시에만 수정/삭제 버튼 보여주기 -->
   
     <input type="button" value="목록" onclick="location.href='galleryList.jsp?pageNum=<%=pageNum %>'">
    </form>
   </section>
  <!-- Center -->
  </nav>
  <!-- Footer -->
  <jsp:include page="../inc/bottom.jsp"/>
  <!-- Footer -->
 </body>
</html>