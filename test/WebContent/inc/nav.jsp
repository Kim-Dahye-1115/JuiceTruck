<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String userID = null;
	if (session.getAttribute("nick") != null) {
		userID = (String) session.getAttribute("nick");
	}
%>
<head>
	<title>주변에서 스피드하게!주스트럭</title>
	<script src="./assets/js/bootstrap.js"></script>
	<link rel="stylesheet" href="./css/bootstrap.css">
	<link rel="stylesheet" href="./css/custom.css">
	<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Material+Icons" />
</head>


<nav class="navbar navbar-default">
	<div class="navbar-header">
		<button type="button" class="navbar-toggle collapsed"
			data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
			aria-expanded="false">
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
		</button>
		<a class="navbar-brand" href="#">Juice Truck</a>
	</div>
	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		<ul class="nav navbar-nav">
			<li><a href="./index">메인</a></li>
			<li><a href="./find">친구찾기</a></li>
			<li><a href="./box">메세지함<span id="unread" class ="label label-info"></span></a></li>
		</ul>
		<%-- <%
			if (userID == null) {
		%>
		<ul class="nav navbar-nav navbar-right">
			<li class="dropdown"><a href="#" class="dropddown-toggle"
				data-toggle="dropdown" role="button" aria-haspopup="true"
				aria-expanded="false">접속하기<span class="caret"></span></a>
				<ul class="dropdown-menu">
					<li><a href="login.jsp">로그인</a></li>
					<li><a href="join.jsp">회원가입</a></li>
				</ul>
			</li>
		</ul>
		<%
			} else {
		%>
		<ul class="nav navbar-nav navbar-right">
			<li class="dropdown"><a href="#" class="dropddown-toggle"
				data-toggle="dropdown" role="button" aria-haspopup="true"
				aria-expanded="false"><%=userID%>님<span class="caret"></span></a>
				<ul class="dropdown-menu">
					<li><a href="update.jsp">정보수정</a></li>
					<li><a href="profileUpdate.jsp">프로필 수정</a></li>
					<li><a href="logoutAction.jsp">로그아웃</a></li>
					<li><a href="../member/userDelete.jsp">회원탈퇴</a></li>
				</ul></li>
		</ul>
		<%
			}
		%> --%>
	</div>
</nav>
