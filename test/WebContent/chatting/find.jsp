<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if(userID == null) {
			session.setAttribute("messageType", "오류 메세지");
			session.setAttribute("messageContnet", "현재 로그인이 되어있지 않습니다.");
			response.sendRedirect("index.jsp");
			return;
		}
	%>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device, initial-scale=1">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="../assets/js/bootstrap.js"></script>
	<link rel="stylesheet" href="../css/bootstrap.css">
	<link rel="stylesheet" href="../css/custom.css">
	<script type="text/javascript">  //친구찾기 기능이 부여된 에이잭스를 쓰기 위해 자바스크립트 선언
		function findFunction(){
			var userID = $('#findID').val(); // 유저 아이디라는 변수를 만들어서, findID라는 ID값이 가지는 값을 가져 옴. (104번줄 findID)
			$.ajax({ //에이잭스
				type :"POST", //포스트방식
				url :'../UserFindServlet', //
				data: {userID: userID},
				success : function(result) {
					if(result == -1) {
						$('#checkMessage').html('친구찾기에 실패했습니다.');
						$('#checkType').attr('class', 'modal-content panel-warning');
						failFriend();
					} else {
						$('#checkMessage').html('친구찾기에 성공했습니다.');
						$('#checkType').attr('class', 'modal-content panel-success');
						var data = JSON.parse(result);
						var profile = data.userProfile;
						getFriend(userID, profile);
					}
					$('#checkModal').modal("show");
				}
			});
		}
		function getFriend(findID, userProfile) {
			$('#friendResult').html('<thead>' + 
					'<tr>' +
					'<th><h4>검색 결과</h4></th>' +
					'</tr>' +
					'</thead>' +
					'<tbody>' +
					'<tr>' +
					'<td style="text-align:center;">' +
					'<img class="media-object img-circle" style="max-width:300px; margin : 0 auto;" src="'+userProfile +'">' +
					'<h3>' + findID + '</h3><a href ="chat.jsp?toID=' + encodeURIComponent(findID) + '" class ="btn btn-primary pull-right">' + '메세지 보내기</a></td>' +
					'</tr>' +
					'</tbody>');
		}
		function failFriend() {
			$('#friendResult').html('');
		}
		function getUnread() {
			$.ajax({
				type: "post",
				url : "../chatUnread",
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
	<div class="container">
		<table class ="table talbe-boarded table-hover" style = "text-align : center; border : 1px solid #dddddd"> <!-- 친구찾기 디자인 -->
			<thead>
				<tr>
					<th colspan ="2"><h4>검색으로 친구찾기</h4></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td style = "width : 110px;"><h5>친구 아이디</h5></td>
					<td><input class ="form-control" type="text" id ="findID" placeholder="찾을 친구의 아이디를 입력하세요" name="userID" maxlength="20"></td>
				</tr>
				<tr>
					<td colspan = "2" style ="text-align:left;"><button class="btn btn-primary pull-right" onclick ="findFunction();">검색</button></td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class ="container">
		<table id ="friendResult" class ="table talbe-borded table-hover" style ="text-align:center; border: 1px solid #dddddd">
		</table>
	</div>
	<%
	String messageContent = null;
	if(session.getAttribute("messageContent") != null) {
		messageContent = (String) session.getAttribute("messageContent");
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
	<%
		session.removeAttribute("messageContent");
		session.removeAttribute("messagetype");
	}
	if(userID != null) {
	%>
	<script type="text/javascript">
		$(document).ready(function() {
			getUnread();
			getInfiniteUnread();
		});
	</script>
	<%
	}
	%>
	<div class ="modal fade" id ="checkModal" tabindex="-1" role ="dialog" aria-hidden="true">
		<div class ="vertical-alignment-helper"	>
			<div class ="modal-dialog vertical-align-center">
				<div id ="checkType" class ="modal-content panel-info">
					<div class ="modal-header panel-heading">
						<button type = "button" class ="close" data-dismiss="modal">
							<span aria-hidden ="true">&times</span>
							<span class ="sr-only">Close</span>
						</button>
						<h4 class ="modal-title">
							확인 메시지
						</h4>
					</div>
					<div id ="checkMessage" class ="modal-body">
					</div>
					<div class ="modal-footer">
						<button type ="button" class ="btn btn-primary" data-dismiss="modal">확인</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>