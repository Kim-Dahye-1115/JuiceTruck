<%@page import="com.member.db.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.net.URLDecoder"%>
<!DOCTYPE html>
<html>
<head>
<%
		String userID = null;
		if(session.getAttribute("nick") != null) {
			userID = (String) session.getAttribute("nick");
		}
		String toID = null; 
		if(request.getParameter("toID") != null) { //널값이 아니라면, 즉 존재한다면 값을 가지고 있을 수 있도록 만들어 주는 코드 
			toID = (String) request.getParameter("toID");
		}
		if(userID == null) {
			session.setAttribute("messageType", "오류 메세지");
			session.setAttribute("messageContent", "현재 로그인이 되어 있지 않은 상태 입니다.");
			response.sendRedirect("./index");
			return;
		}
		if(toID == null) {
			session.setAttribute("messageType", "오류 메세지");
			session.setAttribute("messageContent", "대화 상대가 지정되지 않은 상태 입니다.");
			/* response.sendRedirect("index.jsp"); */
			return;
		}
		if(userID.equals(URLDecoder.decode(toID,"UTF-8"))) {
			session.setAttribute("messageType", "오류 메세지");
			session.setAttribute("messageContent", "자신에게는 쪽지를 보낼 수 없습니다.");
			/* response.sendRedirect("index.jsp"); */
			return;
		}
		String fromProfile = new MemberDAO().getProfile(userID);
		String toProfile = new MemberDAO().getProfile(toID);
		
	%>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script type="text/javascript">
	
		function autoClosingAlert(selector, delay) {
			var alert = $(selector).alert();
			alert.show(); //팝업처럼 보여지도록 만들어주는 코드 
			window.setTimeout(function() {alert.hide()}, delay); //딜레이 만큼의 시간 만큼만 보여주게 해주는 코드
		}
		
		function submitFunction() { //실제로 메세지를 보내주는 submitFunction이라는 함수
			var fromID = '<%=userID%>';  /*  메세지를 보내게 되면 userID가 from ID가 되게 해주는 코드 */
			var toID = '<%=toID%>';
			var chatContent = $('#chatContent').val(); /* 채팅창에 입력한 값이 chatContent라는 변수안에 담기게 해주는 코드 (chat 페이지 206번째 줄) */
			$.ajax({
				type:"POST", //포스트 방식으로 상대방에게 전달되게 해주는 코드
				url: "./chatSubmitServlet", //chatSubmitServlet이 실행되게 해주는 코드 
				data: {
					fromID : encodeURIComponent(fromID), //보내지는 데이터를 인코딩 해서 실제로 보내주는 코드
					toID : encodeURIComponent(toID), //보내지는 데이터를 인코딩 해서 실제로 보내주는 코드
					chatContent : encodeURIComponent(chatContent), //보내지는 데이터를 인코딩 해서 실제로 보내주는 코드
				},
				success: function(result) { //성공적으로 데이터가 보내졌다면 result에 결과가 담기게 됨 
					if(result == 1) { // result 값이 1이라면
						autoClosingAlert('#successMessage', 2000); //result 값이 1이라면 Alert 문장을 출력해주는 코드  //Alert문장 : 223번째 줄 
					} else if(result == 0) { 
						autoClosingAlert('#dangerMessage', 2000); 
					} else {
						autoClosingAlert('#warningMessage', 2000);
					}
				}
			});
			$('#chatContent').val(''); //메세지를 보냈기 때문에 chat Content 값을 비워주는 코드 
		}
		var lastID = 0; //가장 마지막으로 한 대화 데이터의 챗 아이디가 됨
		function chatListFunction(type) { //chatListFunction 이라는 하나의 함수
			var fromID = '<%= userID %>'; 
			var toID = '<%= toID %>';
			$.ajax({ 
				type:"POST", //POST 방식으로서 다른사람이 쉽게 볼 수 없는 형태로 만들어주는 코드
				url: "./chatListServlet", 
				data: {
					fromID : encodeURIComponent(fromID),
					toID : encodeURIComponent(toID),
					listType : type
				},
				success: function(data) { //성공적으로 에이젝스가 통신을 수행했다면 제이슨 데이터가 담기게 됨
					if(data == "") return; //데이터가 공백이라면 리턴,
					var parsed = JSON.parse(data); //공백이 아니라면 해당 데이터를 제이슨 형태로 파싱
					var result = parsed.result; //제이슨으로 파싱된 데이터를  result에 담아 줌
					for(var i = 0; i < result.length; i++) { // i가 0부터 result의 뒤에까지 반복하면서 
						if(result[i][0].value == fromID) {//메세지를 보낸 사람이 자기 자신의 아이디와 같다면
							result[i][0].value = '나'; // "나" 라고 출력할수 있도록 해주는 코드
						}
						addChat(result[i][0].value, result[i][2].value, result[i][3].value); //실제로 화면에 하나하나 출력해주는 코드 
					}
					lastID = Number(parsed.last); //chatListServlet에서 가장 마지막으로 전달 받은 ChatID를 가져올 수 있도록 해주는 코드 chatListServlet 77번째 줄
				}
			});
		}
		
		//채팅을 보낸 사람, 컨텐트, 시간을 화면에 실제로 출력해 줄 수 있도록 만들어주는 코드
		//채팅을 보낸 사람, 컨텐트, 시간을 화면에 실제로 출력해 줄 수 있도록 만들어주는 코드
		function addChat(chatName, chatContent, chatTime) { 
			if(chatName == '나') {
				
				$('#chatList').append('<div class="row">' +
						'<div class="col-lg-12">' +
						'<div class="media">' +
						'<a class="pull-left" href ="#">' +
						'<img class="media-object img-circle" style ="width:50px; height :50px;" src ="<%=fromProfile%>" alt="">' +
						'</a>' +
						'<div class="media-body">' +
						'<h4 class="media-heading">' +
						chatName +
						'<span class="small pull-right">' +
						chatTime +
						'</span>' +
						'</h4>' +
						'<p>' +
						chatContent +
						'</p>' +
						'<div id="div_1"></div>'+
						'</div>' +
						'</div>' +
						'</div>' +
						'</div>' +
						'<hr>');
			
			} else {
				$('#chatList').append('<div class="row">' +
						'<div class="col-lg-12">' +
						'<div class="media">' +
						'<a class="pull-left" href ="#">' +
						'<img class="media-object img-circle" style ="width:50px; height :50px;" src ="<%=toProfile%>" alt="">' +
						'</a>' +
						'<div class="media-body">' +
						'<h4 class="media-heading">' +
						chatName +
						'<span class="small pull-right">' +
						chatTime +
						'</span>' +
						'</h4>' +
						'<p>' +
						chatContent +
						'</p>' +
						'<div id="div_1"></div>'+
						'</div>' +
						'</div>' +
						'</div>' +
						'</div>' +
						'<hr>');
			}
			$("#div_1").load("../chatting/map.jsp");
			$('#chatList').scrollTop($('#chatList')[0].scrollHeight); //스크롤을 가장 아래쪽으로 내려 줌으로써 메세지가 올 때 마다 성공적으로 메세지를 잘 보여줄 수 있는 코드
		}
		//채팅을 보낸 사람, 컨텐트, 시간을 화면에 실제로 출력해 줄 수 있도록 만들어주는 코드
		//채팅을 보낸 사람, 컨텐트, 시간을 화면에 실제로 출력해 줄 수 있도록 만들어주는 코드
		function getInfiniteChat(){ //getInfiniteChat이라는 함수. 몇초 간격으로 새로운 메세지가 왔는지 가져오는 것을 의미 해주는 코드
			setInterval(function() { //chatListFunction이 계속해서 실행 될 수 있게 만들어 주는 코드
				chatListFunction(lastID); 
			}, 3000); //3초에 한번씩 실행 292번째줄과 연결
		}
		function getUnread() {
			$.ajax({
				type: "post",
				url : "./chatUnread",
				data: {
					userID : encodeURIComponent('<%=userID%>'), 
				},
			success : function(result) {
				if(result >= 1) {
					showUnread(result);
				} else {
					showUnread('');
				}
			}
			});
		}
		function getInfiniteUnread() {
			setInterval(function() {
				getUnread();
			}, 4000);
		}
		function showUnread(result) {
			$('#unread').html(result);
		}
	</script>
</head>
<body>
	<!-- 네비게이션 -->
	<jsp:include page="../inc/nav.jsp" />
	<!-- 네비게이션 -->
	
	<!-- 채팅창 디자인 -->
	<!-- 채팅창 디자인 -->
	<!-- 채팅창 디자인 -->
	<div class ="container bootstrap snippet">  
		<div class ="row">
			<div class ="col-xs-12">
				<div class ="portlet portlet-default">
					<div class ="portlet-heading">
						<div class ="portlet-title">
							<h4><i class ="fa fa-circle text-green"></i>실시간 채팅창</h4>
						</div>
						<div class ="clearfix"></div>
					</div>
					<div id ="chat" class="panel-collapse collapse in">
						<div id ="chatList" class ="portlet-body chat-widget" style ="overflow-y : auto; width : auto; height : 400px;">
						</div>
						
	<!-- 채팅창 하단 메뉴바 -->
	<!-- 채팅창 하단 메뉴바 -->
	<!-- 채팅창 하단 메뉴바 -->
	<!-- 채팅창 하단 메뉴바 -->
	
				<nav class="navbar navbar-default">
				<div class="navbar-header">
				
					<button type="button" id="img_btn">
					  <img src="./images/map.png" width="50" height="50" onclick="location.href='./map?toID=<%=toID %>';" >
					</button> 
				</div>
				</nav>
						
						
						<div class ="portlet-footer">
							<div class ="row" style ="height 90px;">
								<div class ="form-group col-xs-10">
									<textarea style ="height 80px;" id = "chatContent" class ="form-control" placeholder="메세지를 입력하세요." maxlength ="100"></textarea> <!-- 에이잭스에 chatContent가 담기게 됨 -->
									
								</div>
								<div class ="form-group col-xs-2">
									<button type ="button" class ="btn btn-default pull-right" onclick="submitFunction();">전송</button> <!--  전송버튼을 누르게 되면 submitFunction 이라는 자바스크립트 실행 -->
									<div class ="clearfix"></div>
								</div>
								
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 채팅방 알림창 -->
	<!-- 채팅방 알림창 -->
	<!-- 채팅방 알림창 -->
	<div class ="alert alert-success" id ="successMessage" style ="display:none;">
		<strong>메세지 전송에 성공했습니다.</strong>
	</div>
	<div class ="alert alert-danger" id ="dangerMessage" style ="display:none;">
		<strong>이름과 내용을 모두 입력해주세요.</strong>
	</div>
	<div class ="alert alert-warning" id ="warningMessage" style ="display:none;">
		<strong>데이터베이스 오류가 발생했습니다.</strong>
	</div>
	<!-- 채팅방 알림창 -->
	<!-- 채팅방 알림창 -->
	<!-- 채팅방 알림창 -->
	
	
	<!-- 채팅창 디자인 -->
	<!-- 채팅창 디자인 -->
	<!-- 채팅창 디자인 -->
	<!-- 채팅창 디자인 -->
	<%
	String messageContent = null;
	if(session.getAttribute("messageContent") != null) {
		messageContent = (String) session.getAttribute("messageContent");
		System.out.println("messageContent : "+messageContent);
	}
	
	String messageType = null;
	if(session.getAttribute("messageType") != null) {
		messageType = (String) session.getAttribute("messageType");
	}
	
	if(messageContent != null) {
	%>
	<div class = "modal fade" id ="messageModal" tabindex ="-1" role ="dialog" aria-hidden ="true">
		<div class ="vertical-alignment-helper"	>
			<div class ="modal-dialog vertical-align-center">
				<div class ="modal-content" <%if(messageType.equals("오류 메시지")) out.println("panel-warning"); %>>
					<div class ="modal-header panel-heading">
						<button type = "button" class ="close" data-dismiss="modal">
							<span aria-hidden ="true">&times</span>
							<span class ="sr-only">Close</span>
						</button>
						<h4 class ="modal-title">
							<%= messageType %>
						</h4>
					</div>
					<div class ="modal-body">
						<%=messageContent %>
					</div>
					<div class ="modal-footer">
						<button type ="button" class ="btn btn-primary" data-dismiss="modal">확인</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$('#messageModal').modal("show"); 
	</script>
	
	<!-- 특정한 시간을 주기로 대화 목록을 데이터 베이스에서 불러 올 수 있는 코드 -->
	<!-- 특정한 시간을 주기로 대화 목록을 데이터 베이스에서 불러 올 수 있는 코드 -->
	<%
		session.removeAttribute("messageContent");
		session.removeAttribute("messagetype");
	}
	%>
	<script type="text/javascript">
		$(document).ready(function() { //157번째 코드를 실행해주는 코드
			getUnread();
			chatListFunction('0');
			getInfiniteChat();
			getInfiniteUnread();
		});
		/* 특정한 시간을 주기로 대화 목록을 데이터 베이스에서 불러 올 수 있는 코드 */
		/* 특정한 시간을 주기로 대화 목록을 데이터 베이스에서 불러 올 수 있는 코드 */
	</script>
</body>
</html>