<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	    <meta charset="utf-8">
	</head>
	<body>
		<%-- <%
		  request.setCharacterEncoding("utf8");
		%>
		<form action="./map" method="post">
			<input type="hidden" value="${param.clickLatlng }" name="clickLatlng">
		</form>	
			<!-- 지도를 표시할 div 입니다 -->
			<div id="map" style="width:50px;height:50px;"></div>
			<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a0249e32978fe616092a08b629770b7a"></script>
			<script>
				var clickLatlng = document.forms[0].clickLatlng.value;
				var latitude = clickLatlng.split(",")[0];
				var longitude = clickLatlng.split(",")[1];
	
				if(clickLatlng == null || clickLatlng == ""){
				 latitude = 33.450701;
				 longitude = 126.570667;
				}
				
				// 마커가 표시될 위치입니다 
				var markerPosition  = new kakao.maps.LatLng(latitude, longitude);
				
				// 마커를 생성합니다
				var marker = {
				    position: markerPosition
				};
				
				var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
				    mapOption = { 
				        center: new kakao.maps.LatLng(latitude, longitude), // 지도의 중심좌표
				        level: 3, // 지도의 확대 레벨
				        marker: marker //이미지 지도에 표시할 마커
					};
				
				var staticMap = new kakao.maps.StaticMap(mapContainer, mapOption);
			</script> --%>
	</body>
</html>