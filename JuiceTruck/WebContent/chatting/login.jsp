<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device, initial-scale=1">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="../assets/js/bootstrap.js"></script>
	<link rel="stylesheet" href="../css/bootstrap.css">
	<link rel="stylesheet" href="../css/custom.css">
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("nick") != null) {
			userID = (String) session.getAttribute("nick");
		}
		
		if(userID != null) {
			session.setAttribute("messageType", "오류 메세지");
			session.setAttribute("messageContent", "현재 로그인이 되어 있는 상태 입니다.");
			response.sendRedirect("./index");
			return;
		}
		
	%>
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
						<button type ="button" class ="btn btn-primary" data-dismiss="modal" onclick="window.open('','_self').close();">확인</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>