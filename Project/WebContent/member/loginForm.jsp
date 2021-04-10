<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
 <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>PORTFOLIO 로그인페이지</title>
  <link rel="stylesheet" href="../css/member.css">
  <script type="text/javascript">
    /* 유효성 체크 */
    function check(){
    	var id = document.forms[0].id;
    	var pw = document.forms[0].pw;
    	
    	if(id.value == ""){
    		alert("아이디를 입력하세요.");
    		id.focus();
    		return false;
    	}
    	if(pw.value == ""){
    		alert("비밀번호를 입력하세요.");
    		pw.focus();
    		return false;
    	}
    }
  </script>
 </head>
 
 <body>
   <!-- Header -->
   <!-- Header -->
   <!-- Left -->
   <div class="left">clear</div>
   <!-- Left -->
   <!-- Center -->
    <section class="member_input">
      <form action="loginPro.jsp" method="post" onsubmit="return check();">
        <fieldset>
          <legend>Login Page</legend>
          <label>아이디<br>
            <input type="text" name="id">
          </label><br><br>
          <label>비밀번호<br>
            <input type="password" name="pw">
          </label><br>
          <input type="button" value="홈으로" onclick="location.href='../main/main.jsp'">
          <input type="button" value="회원가입" onclick="location.href='joinForm.jsp'">
          <input type="submit" value="로그인">
        </fieldset>
      </form>
  </section>
  <!-- Center -->
  <div class="right">clear</div>
  <!-- Footer -->
  <!-- Footer -->
 </body>
</html>