<%@page import="com.portfolio.Gallery.GalleryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>갤러리 태그 수정</title>
 </head>
 <body>
  <%
    request.setCharacterEncoding("utf8");
    String id = (String) session.getAttribute("id");
    if(id == null){
    	response.sendRedirect("galleryList.jsp");
    }
  
    String pageNum = request.getParameter("pageNum");
    int num = Integer.parseInt(request.getParameter("num"));
    String[] tagBuffer = request.getParameterValues("re_tag");
    
    String tag = null;
    if(tagBuffer != null){
    	tag = "#"+tagBuffer[0];
        for(int i=1;i<tagBuffer.length;i++){
        	tag = tag+"#"+tagBuffer[i];
        }
    }
    System.out.println("re_tag >> "+tag);
    
    GalleryDAO gdao = new GalleryDAO();
    int check = gdao.galleryIDcheck(num, id);
    /* 이미지 존재&아이디 일치 : 1 , 이미지 존재&아이디 불일치 : 0 , 이미지 존재 X : -1 */
    switch(check){
    case 1:
        gdao.updateGalleryTag(num, tag);
    	%>
 	  	<script type="text/javascript">
	  	 alert("갤러리 이미지의  태그가 수정 되었습니다.");
	  	 location.href="galleryList.jsp?pageNum=<%=pageNum%>";
	  	</script>
	  	<%
  		break;
    case 0:
	  	%>
	  	<script type="text/javascript">
	  	 alert("아이디를 확인 해주세요.");
	  	 history.back();
	  	</script>
	  	<%
  		break;
    case -1:
	  	%>
	  	<script type="text/javascript">
	  	 alert("이미지가 존재하지 않습니다.");
	  	 history.back();
	  	</script>
	  	<%
	  	break;
    }
  %>
 </body>
</html>