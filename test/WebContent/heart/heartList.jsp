<!-- 사이트 들어오자마자 보이는 메인페이지=상품 리스트입니다. -->
<%@page import="com.market.db.HeartBean"%>
<%@page import="com.market.db.GoodsBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
   
   <!-- 스크립트추가  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->  
<script type="text/javascript">
	var date = null;
		
	function timeForToday(value) {
        var today = new Date();
        var timeValue = new Date(value);

        var betweenTime = Math.floor((today.getTime() - timeValue.getTime()) / 1000 / 60);
        var betweenTimeDay = Math.floor(betweenTime / 60 / 24);
        var betweenTimeMonth =  Math.floor(betweenTime / 60 / 24 / 30);
        

        if (betweenTimeDay < 30) {
        	date = betweenTimeDay+'일전';
        }else if(betweenTimeMonth<12){
        	date = betweenTimeMonth+'달전';
        }else{
        	date = Math.floor(betweenTimeDay / 365)+'년전';
        }
	}
	
	$(function(){
		var dateCnt = '<%=heartList.size() %>';
			
		for(var i=0; i<dateCnt; i++){
			var v = $('#d'+i).html();
			timeForToday(v);
			if(date == "0일전"){
				date = "오늘";
			}
			$('#d'+i).html(date);
		}

	});
</script>
<!-- 스크립트추가  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->

<!-- 게시판 -->
    <div class="main main-raised">
           
        <!-- section -->
        <div class="section">
				<h3>찜목록</h3>
                        <div class="row line1">
     <!-- 반복문 -->                     
     <%for(int i=0;i<heartList.size();i++){ 
               HeartBean hb = (HeartBean)heartList.get(i);
     %>                  

                          <!-- 반복 시작 -->
                            <div class="card col-md-2 mp">
                                <div class="card card-product card-plain no-shadow" data-colored-shadow="false">
                                    <div class="card-header card-header-image">
                                        <a href="./GoodsDetail.ag?num=<%=hb.getH_g_num()%>">
                                            <img class="image0" src="./upload/<%=hb.getH_g_img().split(",")[0] %>">
                                        </a>
                                    </div>
                                    <div class="card-body">
                                        <a href="./GoodsDetail.ag?num=<%=hb.getH_g_num()%>">
                                            <h4 class="card-title"><%=hb.getH_g_name() %></h4>
                                        </a>
                                      <div class="title-time">
                                      	<div class="h5">
                                      		<fmt:formatNumber value="<%=hb.getH_g_price() %>" pattern="#,###"/>원</div>
                                            <small id="d<%=i %>"><%=hb.getH_date() %></small>
                                      </div>
	                                      <i class="material-icons pin">place</i>
	                                      <small>
	                                      <%=hb.getH_g_location().split("[0-9]")[0] %>
                                      	  </small>
                                    </div>
                                    
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