<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<%
		String pass = (String) request.getAttribute("findpass");
		request.setCharacterEncoding("UTF-8");
	%>
	
	<form action="./MemberFindPwEmailAction.me" method="post">
		 이메일 : <input type="text" name="email" placeholder="이메일을 입력해주세요" required>
	     <br>
		 전화번호: <input type="text" name="phone" placeholder="핸드폰 번호를 입력해주세요." required>
	     <br>
	     <% if (pass != null){ %>
	     <input type="text" name="Findpw" value="<%=pass%>"><br> 
	     <% } %>
	     <input type="submit" value="Find PW">
	     <input type="button" value="로그인" onclick="location.href='./MemberLogin.me'">
     </form>
</body>
</html>