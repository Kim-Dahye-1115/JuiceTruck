<%@page import="com.portfolio.Gallery.GalleryDAO"%>
<%@page import="com.portfolio.Gallery.GalleryBean"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>갤러리 업로드</title>
 </head>
 <body>
  <%
    String uploadPath = request.getRealPath("/gallery_upload");
  
    System.out.println("gallery upload path : "+uploadPath);
    
    int fileSize = 10 * 1024 * 1024;
    
    MultipartRequest multi = new MultipartRequest(
    								request, uploadPath, fileSize,
    								"utf8", new DefaultFileRenamePolicy());
    
    System.out.println("gallery image upload success ! ");
    
    String id = multi.getParameter("id");
    String[] tagBuffer = multi.getParameterValues("tag");
    String filename = multi.getFilesystemName("filename");
    String oFilename = multi.getOriginalFileName("filename");
    
    String tag = null;
    if(tagBuffer != null){
    	tag = "#"+tagBuffer[0];
        for(int i=1;i<tagBuffer.length;i++){
        	tag = tag+"#"+tagBuffer[i];
        }
    }
    
    //자바빈 객체 생성
    GalleryBean gb = new GalleryBean();
    gb.setId(id);
    gb.setTag(tag);
    gb.setFile("../gallery_upload/"+filename);
    
    //DAO
    GalleryDAO gdao = new GalleryDAO();
    gdao.insertGallery(gb);
  %>  
  <script type="text/javascript">
    alert("갤러리 업로드 완료 ! ");
    location.href = "galleryList.jsp";
  </script>
 </body>
</html>