<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
 <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>PORTFOLIO 회원가입페이지</title>
  <link rel="stylesheet" href="../css/member.css">
  <script type="text/javascript">
    /* 유효성 체크 */
    function check(){
    	var id = document.forms[0].id;
    	var pw = document.forms[0].pw;
    	var pw_check = document.forms[0].pw_check;
    	var email = document.forms[0].email;
    	
    	if(id.value == "" || id.value.length>10){
    		alert("아이디를 입력하세요.");
    		id.focus();
    		return false;
    	}
    	if(pw.value == "" || pw.value.length<4 || pw.value.length>12){
    		alert("비밀번호를 입력하세요.");
    		pw.focus();
    		return false;
    	} else if(pw.value != pw_check.value){
    		alert("비밀번호가 다릅니다.");
    		pw.focus();
    		return false;
    	}
    	if(email.value == ""){
    		alert("이메일을 입력하세요.");
    		email.focus();
    		return false;
    	}
    }
  </script>
  
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script>
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();
            }
        }).open();
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
      <form action="joinPro.jsp" method="post" onsubmit="return check();">
        <fieldset>
          <legend>* 필수 입력 사항</legend>
          <label>아이디<br>
            <input type="text" name="id" placeholder="아이디를 입력하세요(10자리 이하)" maxlength="10">
          </label><br>
          <label>비밀번호<br>
            <input type="password" name="pw" placeholder="비밀번호를 입력하세요(4~12자리)"maxlength="12">
          </label><br>
          <label>비밀번호 재확인<br>
            <input type="password" name="pw_check" placeholder="비밀번호를 입력하세요(4~12자리)"maxlength="12">
          </label><br>
          <label>이메일<br>
            <input type="email" name="email" placeholder="이메일을 입력하세요">
          </label><br>
        </fieldset>
        
        <fieldset>
          <legend>* 선택 입력 사항</legend>
          <!-- <img alt="profile_img" src="../img/face.png"> -->
          <br><br>
          <label>닉네임<br>
            <input type="text" name="nick" placeholder="닉네임을 입력하세요(6자 이내)" maxlength="6">
          </label><br>
          <label>이름<br>
            <input type="text" name="name" placeholder="이름을 입력하세요">
          </label><br>
          
          <label>주소<br>
		    <input type="text" name="postcode" id="postcode" placeholder="우편번호" readonly>
		    <input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
		    <input type="text" name="address" id="address" placeholder="주소"><br>
		    <input type="text" name="detailAddress" id="detailAddress" placeholder="상세주소">
		    <input type="text" name="extraAddress" id="extraAddress" placeholder="참고항목">
		  </label>
        
        </fieldset>
        <br>
        <input type="submit" value="완료">
        <input type="button" value="취소" onclick="location.href='loginForm.jsp'">
      </form>
  </section>
  <!-- Center -->
  <div class="right">clear</div>
  <!-- Footer -->
  <!-- Footer -->
 </body>
</html>