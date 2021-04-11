<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>주변에서! 스피디하게! 주스트럭</title>
	</head>
	<body>
	
		<%
		  String email = (String) session.getAttribute("email");
		  if(email != null){
			  response.sendRedirect("./GoodsList.ag");
		  }
		%>
		
		<h2> 주스트럭 로그인 페이지 </h2>
		<fieldset>
		  <form action="./MemberLoginAction.me" method="post">
		    이메일 : <input type="email" name="email"> <br>
		    비밀번호 : <input type="password" name="pass"> <br>
		    <hr> 
		    <input type="submit" value="로그인"> <br>
		    <input type="button" value="카카오 아이디 로그인"> <br>
			<input type="button" value="네이버 아이디 로그인"> <br>
		    <input type="button" value="회원가입" onclick=" location.href='./Join.me' "><br>
		    <a href="./MemberFindId.me">아이디 찾기</a>|<a href="./MemberFindPw.me">비밀번호 찾기</a>
		  </form>	
		</fieldset>
	</body>
</html>