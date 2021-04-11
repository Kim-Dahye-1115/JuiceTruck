<!-- 사이트 들어오자마자 보이는 메인페이지=상품 리스트입니다.(은비님) -->
<%@page import="com.market.db.GoodsBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<!-- 헤더 -->
<jsp:include page="../inc/top.jsp"/>
<!-- 헤더 -->

<%
   List<GoodsBean> goodsList 
          = (List<GoodsBean>)request.getAttribute("goodsList");
	
%> 

<div class="main main-raised">
    <div class="section">
		<h3>최근에 등록된 상품</h3>
            <div class="row line1">
                          
  <!-- 게시글 있을 경우 목록 생성 반복문 -->                     
   <%for(int i=0;i<goodsList.size();i++){ 
             GoodsBean gb = goodsList.get(i);
   %>
       <div class="card col-md-2 mp">
           <div class="card card-product card-plain no-shadow" data-colored-shadow="false">
               <!-- 대표 이미지 -->
               <div class="card-header card-header-image">
                  <a href="./GoodsDetail.ag?num=<%=gb.getG_num()%>">
                       <img  class="image0" src="./upload/<%=gb.getImgs().split(",")[0] %>">
                  </a>
               </div>
               <!-- 게시글 제목 -->  
               <div class="card-body">
                  <a href="./GoodsDetail.ag?num=<%=gb.getG_num()%>">
                     <h4 class="card-title card-body">
					        <%=gb.getG_name() %>
                     </h4>
                  </a>
               <div class="title-time">  
                  <div class="h5">
               		<!-- 가격 -->   
                    <fmt:formatNumber value="<%=gb.getPrice() %>" pattern="#,###"/>원</div>
                    <!-- 작성일자 -->
                    <small><%=gb.getDate() %></small>
               </div>
                    <i class="material-icons pin">place</i>
               		<!-- 거래지역 -->
                    <small>
                    <%=gb.getLocation().split("[0-9]")[0] %>
                    </small>
                </div>
            </div>
        </div>
   <%} %>
   <!-- 게시글 있을 경우 목록 생성 반복문 끝 -->                     
          </div>
     </div>
</div>

<!-- 푸터 -->        
	<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터 -->        
</body>

</html>