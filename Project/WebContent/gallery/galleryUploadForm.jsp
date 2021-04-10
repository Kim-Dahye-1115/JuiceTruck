<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
 <head>
  <meta charset="UTF-8">
  <title>PORTFOLIO 갤러리 업로드페이지</title>
  <link rel="stylesheet" href="../css/default.css">
 </head>
 
 <body>
  <!-- Header(top) -->
  <jsp:include page="../inc/top.jsp"/>
  <!-- Header(top) -->
  
  <!-- 로그인 정보 확인 -->
  <%
    String id = (String) session.getAttribute("id");
    if(id == null){
    	response.sendRedirect("galleryList.jsp");
    }
  %>
  <!-- 로그인 정보 확인 -->
  
  <nav>
  <!-- Menubar(left) -->
  <jsp:include page="../inc/leftMenu.jsp"/>
  <!-- Menubar(left) -->
  <div class="center">
  <form action="galleryUploadPro.jsp" method="post" enctype="multipart/form-data">
   <table>
    <tr>
     <td colspan="2" class="td_title">파일 업로드</td>
    </tr>
    
    <tr>
     <td>사용자</td>
     <td>
      <input type="text" name="id" value="<%=id %>" readonly>
     </td>
    </tr>
    
    <tr>
     <td>tag</td>
     <td>
      <label><input type="checkbox" name="tag" value="1">1</label>
      <label><input type="checkbox" name="tag" value="2">2</label>
      <label><input type="checkbox" name="tag" value="3">3</label>
      <label><input type="checkbox" name="tag" value="4">4</label>
     </td>
    </tr>
    
    <tr>
     <td>파일명</td>
     <td>
      <input type="file" name="filename" accept="image/*" required>
     </td>
    </tr>
    
    <tr>
     <td>
      <input type="submit" value="파일 업로드">
     </td>
    </tr>
   </table>
  </form>
  </div>
  <!-- Center -->
  </nav>
  <!-- Footer -->
  <jsp:include page="../inc/bottom.jsp"/>
  <!-- Footer -->
 </body>
</html>