<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%
	String userID = null;
	if(session.getAttribute("nick") != null) {
		userID = (String) session.getAttribute("nick");
	}
%>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device, initial-scale=1">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="../assets/js/bootstrap.js"></script>
	<link rel="stylesheet" href="../css/bootstrap.css">
	<link rel="stylesheet" href="../css/custom.css">
	<script type="text/javascript">
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
						<button type ="button" class ="btn btn-primary" data-dismiss="modal" onclick="window.open('','_self').close();">확인</button>
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
</body>
</html>