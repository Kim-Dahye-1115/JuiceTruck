<%@page import="com.portfolio.Member.MemberBean"%>
<%@page import="com.portfolio.Member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
 <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>PORTFOLIO 회원정보페이지</title>
  <link rel="stylesheet" href="../css/default.css">
  <script type="text/javascript">
    /* 유효성 체크 */
    function check(index){
    	var pw = document.forms[0].pw;

    	if(pw.value == ""){
    		alert("비밀번호를 입력하세요.");
    		pw.focus();
    		return false;
    	}
    	
    	if(index == 0){	//탈퇴
    		var result = confirm("정말 탈퇴하시겠습니까?");
    		if(result){
    			document.forms[0].action='deletePro.jsp';
    		}
    	}
    	if(index == 1){	//수정
    		document.forms[0].action='updatePro.jsp';
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
  <jsp:include page="../inc/top.jsp"/>
  <!-- Header -->

  <!-- Left -->
  <jsp:include page="../inc/leftMenu.jsp"/>
  <!-- Left -->
  
  <!-- Center -->
      <%
        request.setCharacterEncoding("utf8");
      
        String id = (String) session.getAttribute("id");
        if(id == null)	response.sendRedirect("loginForm.jsp");
        
        MemberDAO mdao = new MemberDAO();
        MemberBean mb = mdao.getMember(id);
        
        if(mb.getNick() == null) mb.setNick("");
        if(mb.getName() == null) mb.setName("");
        if(mb.getPostcode() == null) mb.setPostcode("-");
        if(mb.getAddress() == null) mb.setAddress("");
        if(mb.getDetailAddress() == null) mb.setDetailAddress("");
        if(mb.getExtraAddress() == null) mb.setExtraAddress("");
      %>
      <form method="post">
        <fieldset>
          <legend>* 필수 입력 사항</legend>
          <label>아이디<br>
            <input type="text" name="id" value="<%=mb.getId() %>" readonly>
          </label><br>
          <label>비밀번호<br>
            <input type="password" name="pw" placeholder="비밀번호를 입력하세요">
          </label><br>
          <label>이메일<br>
            <input type="email" name="email" value="<%=mb.getEmail() %>" placeholder="이메일을 입력하세요">
          </label><br>
        </fieldset>
        
        <fieldset>
          <legend>* 선택 입력 사항</legend>
          <!-- <img alt="profile_img" src="../img/profile_img_b.png"> -->
          <br><br>
          <label>닉네임<br>
            <input type="text" name="nick" value="<%=mb.getNick() %>" placeholder="닉네임을 입력하세요">
          </label><br>
          <label>이름<br>
            <input type="text" name="name" value="<%=mb.getName() %>" placeholder="이름을 입력하세요">
          </label><br>
          <label>주소<br>
		    <input type="text" name="postcode" id="postcode" placeholder="우편번호" value="<%=mb.getPostcode()%>" readonly>
		    <input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
		    <input type="text" name="address" id="address" placeholder="주소" value="<%=mb.getAddress()%>"><br>
		    <input type="text" name="detailAddress" id="detailAddress" placeholder="상세주소" value="<%=mb.getDetailAddress()%>">
		    <input type="text" name="extraAddress" id="extraAddress" placeholder="참고항목" value="<%=mb.getExtraAddress()%>">
		  </label>
        </fieldset>
        <hr>
        <input type="button" value="취소" onclick="location.href='../main/main.jsp'">
        <input type="submit" value="탈퇴" onclick="check(0);">
        <input type="submit" value="수정" onclick="check(1);">
      </form>
  <!-- Center -->

  <!-- Footer -->
  <!-- Footer -->
 </body>
</html>