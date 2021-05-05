<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	</head>
<body class="login-page ">
	<!-- 헤더 -->
	<jsp:include page="../inc/top.jsp"/>
	<!-- 헤더 -->
	
		<%
		  String email = (String) session.getAttribute("email");
		  if(email != null){
			  response.sendRedirect("./GoodsList.ag");
		  }
		%>
		<div class="member-join">
		<div class="container">
		<div class="section section-text">
			<div class="row">
				<div class="col-md-9 ml-auto mr-auto">
				<div class="col-md-7 ml-auto mr-auto">
				<h3 class="title">주스트럭 로그인 페이지 </h3>
				</div>
		
		<fieldset>
		  <form action="./MemberLoginAction.me" method="post">
		  	<label for="exampleFormControlTextarea1" >이메일</label>
		    <input type="email" name="email" class="form-control maintext"> <br>
		    <label for="exampleFormControlTextarea1" >비밀번호</label>
		    <input type="password" name="pass" class="form-control maintext"> <br>
		    <br>
		    <div class="col-md-7 ml-auto mr-auto fileadd6">
		    <input type="submit" value="로그인" class="btn btn-primary" > 
		    <a href="https://kauth.kakao.com/oauth/authorize?client_id=c9cffd9530ad8456ac8cc3f58d0088b3&redirect_uri=http://itwillbs10.cafe24.com/Juice/oauth/kakao?cmd=callback&response_type=code">
		      <img height="38px" width="150px" src="./images/kakao_login_medium_narrow.png" />
		    </a> <br>
		    <!-- <a href="https://developers.kakao.com/logout"> 로그아웃 </a> -->
		    </div>
		    <br>
		    <div class="col-md-6 ml-auto mr-auto fileadd6">
		    <a class="log"  href="./JoinTerms.me" >회원가입</a>  |  
		    <a class="log" href="./MemberFindId.me">아이디 찾기</a>|<a class="log" href="./MemberFindPw.me">비밀번호 찾기</a><br>
		    </div>
		  </form>	
		</fieldset>
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