<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<% String email = (String) request.getAttribute("findemail");
		request.setCharacterEncoding("UTF-8");
	%>
	
	<form action="./MemberFindIdAction.me" method="post">
		 이름 : <input type="text" name="name" placeholder="이름을 입력해주세요" required>
	     <br>
		 전화번호: <input type="text" name="phone" placeholder="핸드폰 번호를 입력해주세요." required>
	     <br>
	     <% if (email != null){ %>
	     <input type="text" name="Findid" value="<%=email%>"><br> 
	     <% } %>
	     <input type="submit" value="Find ID">
	     <input type="button" value="로그인" onclick="location.href='./MemberLogin.me'">
	     </form>
</body>
</html>