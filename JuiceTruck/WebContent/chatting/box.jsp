<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%
	String userID = null;
	if(session.getAttribute("nick") != null) {
		userID = (String) session.getAttribute("nick");
	}
	
	if(userID == null) {
		session.setAttribute("messageType", "오류 메세지");
		session.setAttribute("messageContent", "현재 로그인이 되어 있지 않은 상태 입니다.");
		response.sendRedirect("./index");
		return;
	}
%>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device, initial-scale=1">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script type="text/javascript">
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
			}, 3000);
		}
		function showUnread(result) {
			$('#unread').html(result);
		}
		function chatBoxFunction() {
			var userID = '<%= userID %>'
			$.ajax({
				type: "post",
				url : "./chatBox",
				data: {
					userID : encodeURIComponent(userID), 
				},
			success : function(data) {
				if(data == "") return;
				$('#boxTable').html('');
				var parsed = JSON.parse(data);
				var result = parsed.result;
				for(var i = 0; i < result.length; i++) {
					if(result[i][0].value == userID) {
						result[i][0].value = result[i][1].value;
					} else {
						result[i][1].value = result[i][0].value;
					}
					addBox(result[i][0].value, result[i][1].value, result[i][2].value, result[i][3].value, result[i][4].value, result[i][5].value);
				}
			}
			});
		}
		function addBox(lastID, toID, chatContent, chatTime, unread, profile) {
			$('#boxTable').append('<tr onclick="location.href=\'./chat?toID=' + encodeURIComponent(toID) + '\'">' +
			'<td style ="width: 150px;">' +
			'<img class="media-object img-circle" style="margin: 0 auto; max-width:40px; max-height:40px;" src="'+profile +'">' +
			'<h5>' + lastID + '</h5></td>' +
			'<td>' +
			'<h5>' + (chatContent.substring(0,7) == "http://" ? '지도': ''+chatContent+'') + '</h5>' +
			'<span class="label laber-info">' + unread + '</span>' +
			'<div class ="pull-right">' + chatTime + '</div>' +
			'</td>' +
			'</tr>');			
		}
		function getInfiniteBox() {
			setInterval(function() {
				chatBoxFunction();
			}, 3000);
		}
	</script>
</head>
<body>
	<!-- 네비게이션 -->
	<jsp:include page="../inc/nav.jsp" />
	<!-- 네비게이션 -->
	<div class = "container">
		<table class ="table" style ="margin : 0 auto;">
			<thead>
				<tr>
					<th><h4>주고받은 메시지 목록</h4></th>
				</tr>
			</thead>
					
			<div style ="overflow-y : auto; width : 100%; max-height: 450px;">
				<table class ="table table-bordered table-hober" style ="text-align: center; border : 1px solid #ddd">
				
					<tbody id ="boxTable">
					</tbody>
				
				</table>
			</div>
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
	%>
	<%
	if(userID != null) {
	%>
	<script type="text/javascript">
		$(document).ready(function() {
			getUnread();
			getInfiniteUnread();
			chatBoxFunction();
			getInfiniteBox();
		});
	</script>
	<%
	}
	%>
</body>
</html>