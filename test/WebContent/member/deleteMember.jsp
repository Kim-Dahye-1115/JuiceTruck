<!-- 회원 탈퇴 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>주위에서 스피디하게!주스트럭</title><!-- 웹페이지 타이틀에 쓸 문구 의논해요! -->
	</head>
	<body class="delete-page ">
	<!-- 헤더 -->
	<jsp:include page="../inc/top.jsp"/>
	<!-- 헤더 -->
	<%
	  String email = (String) session.getAttribute("email");
	  if(email == null){
		  response.sendRedirect("./MemberLogin.me");
	  }
	%>
	<div class="member-join">
		<div class="container">
		<div class="section section-text">
			<div class="row">
				<div class="col-md-9 ml-auto mr-auto">
				<h3 class="title">회원 탈퇴</h3>
		<form method="post" action="./MemberDeleteAction.me">
			<label for="exampleFormControlTextarea1" >탈퇴를 위해 비밀번호를 입력하세요.</label>
	 		<input type="password" class="form-control maintext" placeholder="비밀번호를 입력하세요." name="pass" maxlength="20">
			<br>
			<div class="col-md-5 ml-auto mr-auto fileadd6">
			<input type="submit" class="btn btn-primary" value="탈퇴하기">
			<input type="button" class="btn btn-primary" value="돌아가기" onclick="location.href='./GoodsList.ag'">
			</div>
		</form>
	</div>
		</div>
		</div>
		</div>
		</div>
	<!-- 푸터 -->
	<jsp:include page="../inc/bottom.jsp"/>
	<!-- 푸터 -->
	</body>
</html>