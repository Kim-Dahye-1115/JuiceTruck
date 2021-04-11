<!-- 회원 탈퇴 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>주위에서 스피디하게!주스트럭</title><!-- 웹페이지 타이틀에 쓸 문구 의논해요! -->
	</head>
	<body>
	<!-- 헤더 -->
	<!-- 헤더 -->
	<%
	  String email = (String) session.getAttribute("email");
	  if(email == null){
		  response.sendRedirect("./MemberLogin.me");
	  }
	%>
	
		<h2>회원탈퇴</h2>
		<form method="post" action="./MemberDeleteAction.me">
			<h4>탈퇴를 위해 비밀번호를 입력하세요.</h4>
	 		<input type="password" placeholder="비밀번호를 입력하세요." name="pass" maxlength="20">
			<br>
			<input type="submit" value="탈퇴하기">
			<input type="button" value="돌아가기" onclick="location.href='./Main.me'">
		</form>
	
	<!-- 푸터 -->
	<!-- 푸터 -->
	</body>
</html>