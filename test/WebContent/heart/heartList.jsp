<!-- 사이트 들어오자마자 보이는 메인페이지=상품 리스트입니다. -->
<%@page import="com.market.db.HeartBean"%>
<%@page import="com.market.db.GoodsBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>      
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 웹페이지 타이틀에 쓸 문구 의논해요! -->
</head>
<body>
<!-- 헤더 -->
<jsp:include page="../inc/top.jsp"/>
<!-- 헤더 -->

   <%
      List heartList = (List)request.getAttribute("heartList");
   %>

<!-- 게시판 -->
    <div class="main main-raised">
           
        <!-- section -->
        <div class="section">
				<h3>찜목록</h3>
                        <div class="row">
                          <div class="col-md-1"></div>
                          
     <!-- 반복문 -->                     
     <%for(int i=0;i<heartList.size();i++){ 
               HeartBean hb = (HeartBean)heartList.get(i);
     %>                  

                          <!-- 반복 시작 -->
                            <div class="col-md-2">
                                <div class="card card-product card-plain no-shadow" data-colored-shadow="false">
                                    <div class="card-header card-header-image">
                                        <a href="./GoodsDetail.ag?num=<%=hb.getH_g_num()%>">
                                            <img src="./upload/<%=hb.getH_g_img().split(",")[0] %>">
                                        </a>
                                    </div>
                                    <div class="card-body">
                                        <a href="#">
                                            <h4 class="card-title"><%=hb.getH_g_name() %></h4>
                                        </a>
                                      <div class="title-time">  
                                            <div class="h5"><%=hb.getH_g_price() %>원</div>
                                            <small>6분 전</small>
                                      </div>
                                      <i class="material-icons pin">place</i><small><%=hb.getH_g_location() %></small>
                                    </div>
                                    
                                    <!-- 찜목록 삭제 버튼 추가 부분 -->
                                    <div class="col-md-5">
										<button class="btn btn-primary btn-lg"
												onclick="javascript:location.href='./heartDelete.he?num=<%=hb.getH_g_num()%>&h_num=<%=hb.getH_num()%>'"
										>
											<i class="material-icons">favorite</i> 찜목록에서 삭제하기
										</button>
                                    </div>
                                    <!-- 찜목록 삭제 버튼 추가 부분 -->
                                    
                                </div>
                            </div>
                                <!-- 반복 끝 -->
     <%} %>
                               
                          
                    </div>
                </div>
            </div>
        <!-- section -->

<!-- 푸터 -->        
	<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터 -->        
</body>

</html>