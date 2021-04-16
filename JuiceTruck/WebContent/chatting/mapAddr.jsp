<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	    <meta charset="utf-8">
	    <script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	    <script type="text/javascript">
		    function del() {
		        $('#addr').val('');
		    }
		    
		    function lo() {
		    	if($('#clickLatlng').val() == ""){
		    		alert("위치를 선택해 주세요");
		    		return false;
		    	}
		    }
	    </script>
	</head>
	
	<body>
		<%
		  request.setCharacterEncoding("utf8");
		%>
		
		<jsp:include page="../inc/nav.jsp" />
		
		<form action="./mapServlet" method="post" onsubmit="return lo();">
		
			<input type="hidden" value="${param.clickLatlng }" name="clickLatlng" id="clickLatlng">
			<input type="hidden" value="${param.toID }" name="toID">
			<input type="hidden" value="<%=session.getAttribute("nick") %>" name="fromID">
			<input type="hidden" value="http://localhost:8088/Juice/chatting/map.jsp?clickLatlng=" name="mapImg">
			
			<div class="mapSearch">
				<input class="txt_input" type="text" value="${param.addr }" name="addr" id="addr" placeholder="주소를 입력해주세요" autocomplete="off">
				<a onclick="del();"><i class="material-icons">clear</i></a>
				<a id="search"><i class="material-icons">search</i></a>
				<input class="map_btn" type="submit" value="위치공유">
				<input class="map_btn" type="button" value="돌아가기" onclick="history.back();">
			</div>
		</form>
		
		<br>	
		
		<div id="map" style="width:100%;height:500px;position:relative;overflow:hidden;"></div>
		
		<div class="clear"></div>
		
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a0249e32978fe616092a08b629770b7a&libraries=services"></script>
		<script>
			var clickLatlng = document.forms[0].clickLatlng.value;
			var addr = document.forms[0].addr.value;
			var latitude = clickLatlng.split(",")[0];
			var longitude = clickLatlng.split(",")[1];
			
			if(clickLatlng == null || clickLatlng == ""){
				 latitude = 33.450701;
				 longitude = 126.570667;
			}
			
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			    mapOption = {
			        center: new kakao.maps.LatLng(latitude, longitude), // 지도의 중심좌표
			        level: 3 // 지도의 확대 레벨
			    };  
			
			// 지도를 생성합니다    
			var map = new kakao.maps.Map(mapContainer, mapOption); 
			
			// 주소-좌표 변환 객체를 생성합니다
			var geocoder = new kakao.maps.services.Geocoder();
			
			var marker = new kakao.maps.Marker({
			    position: map.getCenter(),
			});
			
			marker.setMap(map);
			
			var infowindow = new kakao.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다
			
			// 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
			searchAddrFromCoords(map.getCenter(), displayCenterInfo);
			
			// 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
			kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
			    searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
			        if (status === kakao.maps.services.Status.OK) {
			            var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
			            detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';
			            
			            var content = '<div class="bAddr">' +
			                            '<span class="title">법정동 주소정보</span>' + 
			                            detailAddr + 
			                        '</div>';
			
			            // 마커를 클릭한 위치에 표시합니다 
			            marker.setPosition(mouseEvent.latLng);
			            marker.setMap(map);
			
			            // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
			            infowindow.setContent(content);
			            infowindow.open(map, marker);
			        }
			        document.forms[0].addr.value = result[0].address.address_name;
			        
			        var latlng = marker.getPosition();
			        
			        var message = latlng.getLat()+","+latlng.getLng();
				    
				    document.forms[0].clickLatlng.value = message;
			    });
			});
			
			// 주소로 좌표를 검색합니다
			$("#search").on('click', function(MouseEvent) {
				geocoder.addressSearch(document.forms[0].addr.value, function(result, status) {
				    // 정상적으로 검색이 완료됐으면 
				     if (status === kakao.maps.services.Status.OK) {
				        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

				        // 결과값으로 받은 위치를 마커로 표시합니다
				        var marker = new kakao.maps.Marker({
				            map: map,
				            position: coords
				        });

				        // 인포윈도우로 장소에 대한 설명을 표시합니다
				        var infowindow = new kakao.maps.InfoWindow({
				            content: '<div style="width:150px;text-align:center;padding:6px 0;">'+document.forms[0].addr.value+'</div>'
				        });
				        infowindow.open(map, marker);

				        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
				        map.setCenter(coords);
				     }
				    
				     var latlng = marker.getPosition();
				        
				     var message = latlng.getLat()+","+latlng.getLng();
					    
					 document.forms[0].clickLatlng.value = message;
				});
			});
			
			// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
			kakao.maps.event.addListener(map, 'idle', function() {
			    searchAddrFromCoords(map.getCenter(), displayCenterInfo);
			});
			
			function searchAddrFromCoords(coords, callback) {
			    // 좌표로 행정동 주소 정보를 요청합니다
			    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
			}
			
			function searchDetailAddrFromCoords(coords, callback) {
			    // 좌표로 법정동 상세 주소 정보를 요청합니다
			    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
			}
			
			 // 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
			function displayCenterInfo(result, status) {
			    if (status === kakao.maps.services.Status.OK) {
			        var infoDiv = document.getElementById('centerAddr');
			
			        for(var i = 0; i < result.length; i++) {
			            // 행정동의 region_type 값은 'H' 이므로
			            if (result[i].region_type === 'H') {
			                infoDiv.innerHTML = result[i].address_name;
			                break;
			            }
			        }
			    }    
			}
			 
			 /* ---------------------------------------------------------------------- */
			 /* function search(){
				 var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
				    mapOption = {
				        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
				        level: 3 // 지도의 확대 레벨
				    };  

				// 지도를 생성합니다    
				var map = new kakao.maps.Map(mapContainer, mapOption); 

				// 주소-좌표 변환 객체를 생성합니다
				var geocoder = new kakao.maps.services.Geocoder();

				// 주소로 좌표를 검색합니다
				geocoder.addressSearch(document.forms[0].addr.value, function(result, status) {

				    // 정상적으로 검색이 완료됐으면 
				     if (status === kakao.maps.services.Status.OK) {

				        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

				        // 결과값으로 받은 위치를 마커로 표시합니다
				        var marker = new kakao.maps.Marker({
				            map: map,
				            position: coords
				        });

					        // 인포윈도우로 장소에 대한 설명을 표시합니다
					        var infowindow = new kakao.maps.InfoWindow({
				            content: '<div style="width:150px;text-align:center;padding:6px 0;">'+document.forms[0].addr.value+'</div>'
				        });
				        infowindow.open(map, marker);

				        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
				        map.setCenter(coords);
				    } 
				});
			 } */
		</script>
	</body>
</html>