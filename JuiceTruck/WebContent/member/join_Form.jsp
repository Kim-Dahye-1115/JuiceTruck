<!-- 회원가입 페이지(이메일로 가입하기 선택) -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="http://code.jquery.com/jquery-3.5.1.js"></script>
		<script type="text/javascript">
		
			var checkEmail = -1;
			var checkNick  = -1;  
			var numberCheck = 0;
			var phoneCheck = -1;
			var intervalVar = undefined;
			var timeSecond = undefined;
			var num_check1 = undefined; //인증번호
			
		 	//인증번호 발송
		 	$(function() {
				$('#pck').click(function() {
					var phone = $('#phone').val();
					var sendData = "phone=" + phone;

					
					if (phone == ""){
				 		alert("전화번호를 입력하세요.");
				 		return;
				 	}else {
					$.post('./PhoneCheck.me', sendData, function(msg3) {
						// alert(msg3);
						
						$.each(JSON.parse(msg3),function(i,v){
							
							//0 가능
							// alert(v.pnum_check);
							if(v.pnum_check==0){
							num_check1 = v.numStr;
							doTimer();
							// alert(num_check1);
							alert("인증번호가 발송되었습니다.");
							}else{
							alert("사용 중인 전화번호입니다.");
							}
						});
					});
					
					$('#pck').click(function() {
						
						var phone = $('#phone').val();
						var sendData = "phone=" + phone
						
						$.post('./IdCheck.me', sendData, function(msg4) {
							$('#msg4').html(msg);
							 if(msg == "사용 가능한 이메일입니다."){
								 checkEmail = 0;
							} else {
								checkEmail = -1;
							} 
						});
					
				 });
	
	
						
		function doTimer() {
			$('#pckcom').prop('value', '인증번호 확인');
			
			num_check = num_check1;
			// alert(num_check);
			$('#num_check').prop('value', num_check);

			timeSecond = 120;	//유효시간
			$('#timer').prop('value', getTimeString(timeSecond));

			if (intervalVar != undefined) {
				clearInterval(intervalVar);
			}

			intervalVar = setInterval(function() {
			   if (timeSecond != 0) {
				   timeSecond = timeSecond - 1;
				   $('#timer').prop('value', getTimeString(timeSecond));
			   } else {
				   clearInterval(intervalVar);
				   intervalVar = false;
			   }
			   }, 1000);
			}

			function getTimeString(second) {
				var minute = '' + (Math.floor(second / 60));
				var dividedSec = second % 60;
				if (dividedSec < 10) {
					dividedSec = '0' + dividedSec;
				}
				// ex) 3:00 -> 3분
				return minute + ":" + dividedSec;
			}
	
					}
				});
			});
		
				

			//인증번호 확인
			function doCodeCheck() {
				if (!$('#number').prop('value')) {
			                 alert('인증번호를 입력하세요.');
			                 return;
			             }
			             if (timeSecond == 0 || intervalVar == false) {
			                 alert('인증번호 유효시간이 초과하였습니다. 인증번호를 재전송 해주세요.');
			                 return;
			             }
			
				if ($('#num_check').prop('value') == $('#number').prop('value')) {
					
					alert('인증이 완료되었습니다.');
					phoneCheck = 0;
					
					
					$('#pckcom').hide();
					$('#number').hide();
					$('#timer').hide();
				} else {
					phoneCheck = -1;
					alert('인증번호가 일치하지 않습니다.');
				}
			}


	
		 	//아이디 중복체크
		 	$(function() {
				$('#chk').click(function() {
					var email = $('#email').val();
					var sendData = "email=" + email
					
					$.post('./IdCheck.me', sendData, function(msg) {
						$('#msg').html(msg);
						 if(msg == "사용 가능한 이메일입니다."){
							 checkEmail = 0;
						} else {
							checkEmail = -1;
						} 
					});
				});
			});
			
		 	//닉네임 중복체크
		 	$(function() {
				$('#ckn').click(function() {
					var nick = $('#nick').val();
					var sendData = "nick=" + nick
					$.post('./NickCheck.me', sendData, function(msg2) {
						$('#msg2').html(msg2);
						 if(msg2 == "사용 가능한 닉네임입니다."){
							checkNick  = 0;
						} else {
							checkNick  = -1;
						} 
					});
				});
			}); 
			
		 	//이미지 미리보기
		    $(function() {
		        $("#user_img").on('change', function(){
		            readURL(this);
		        });
		    });
		
		    function readURL(input) {
		        if (input.files && input.files[0]) {
		        var reader = new FileReader();
		
		        reader.onload = function (e) {
		                $('#imgPre').attr('src', e.target.result);
		            }
		
		          reader.readAsDataURL(input.files[0]);
		        }
		    }
		    
		    //유효성 체크
			function validate() {
				// 패스워드가 적합한지 검사할 정규식
		       var re = /^[a-zA-Z0-9]{8,20}$/ 
		    	// 이메일이 적합한지 검사할 정규식
		       var re2 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		   		// 이름이 적합한지 검사할 정규식
		       var reName = /^[가-힣]{2,6}$/;
		  		// 닉네임이 적합한지 검사할 정규식(특수문자 사용 불가)
		       var reNick = /^[가-힣a-zA-Z0-9]{2,6}$/;
		  		// 전화번호에 숫자만 사용
		       var rePhone = /^[0-9]{11,11}$/;       
		     
		
		       var email = document.getElementById("email");
		       var pass = document.getElementById("pass");
		       var name = document.getElementById("name");
		       var nick = document.getElementById("nick");
		       var phone = document.getElementById("phone");
		       var addr = document.getElementById("addr");
		       var addr2 = document.getElementById("addr2");
		       
		       var maxSize = 10*1024*1024; //10MB
			   var imgFile = $('#user_img').val();
					
				
				//파일크기제어
				if(imgFile != "" && imgFile != null){
					var fileSize = document.getElementById("user_img").files[0].size;
					if(fileSize>maxSize) {
				    	alert("파일 크기는 10MB까지 가능합니다.");
				        return false;
				    }
				}
		       
			   //이메일 유효성 체크
		       if(email.value=="") {
		           alert("이메일을 입력해 주세요.");
		           email.focus();
		           return false;
		       }
		       if(!check(re2, email, "적합하지 않은 이메일 형식입니다.")) {
		           return false;
		       }
		       
		       if(!(checkEmail == 0) ){
					  alert("이메일 중복 확인을 체크해 주세요.");
			    	   return false;
				  }

		       
		       //비밀번호 유효성 체크
			   if(!check(re,pass,"패스워드는 8~20자 이내 영문 대소문자와 숫자로만 입력하세요.")) {
		           return false;
		       }
			   if(fr.pass.value != fr.pass2.value) {
		           alert("비밀번호가 일치하지 않습니다. 다시 확인해 주세요.");
		           fr.pass2.value = "";
		           fr.pass2.focus();
		           return false;
		       }
				 
				//이름 유효성 체크
				if(name.value=="") {
			           alert("이름을 입력해 주세요");
			           name.focus();
			           return false;
			    }
				if(!check(reName, name, "이름이 올바르지 않습니다.")) {
			           return false;
			    }
				
				//닉네임 유효성 체크
				if(nick.value=="") {
			           alert("닉네임을 입력해 주세요");
			           nick.focus();
			           return false;
			    }
				if(!check(reNick, nick, "닉네임에 특수문자를 사용할 수 없습니다.")) {
			           return false;
			    }
				

				 if(!(checkNick == 0) ){
					  alert("닉네임 중복 확인을 체크해 주세요.");
			    	   return false;
				  }

				
				//전화번호 유효성 체크
				if(phone.value=="") {
			           alert("전화번호를 입력해 주세요");
			           phone.focus();
			           return false;
			    }
				if(!check(rePhone, phone, "전화번호는 11자리 숫자로 입력하세요.")) {
			           return false;
			    }
				
				
				 if(!(phoneCheck == 0) ){
					  alert("핸드폰 인증 확인을 해주세요.");
			    	   return false;
				  }
				  
				
				//주소 유효성 체크
				if(addr.value=="") {
			           alert("주소를 입력해 주세요");
			           addr.focus();
			           return false;
			    }
				
				//상세주소 유효성 체크
				if(addr2.value=="") {
			           alert("상세 주소를 입력해 주세요");
			           addr2.focus();
			           return false;
			    }
		
			    alert("회원가입이 완료되었습니다.");
		   	}
			
			function check(re, what, message) {
			       if(re.test(what.value)) {
			           return true;
			       }
			       alert(message);
			       what.value = "";
			       what.focus();
			       //return false;
			}
		</script>
	</head>
	
	
<body class="join-page ">
<!-- 헤더 -->
<jsp:include page="../inc/top.jsp"/>
<!-- 헤더 -->
		
		<%
		  String email = (String) request.getAttribute("email");
		  if(email != null){
			  response.sendRedirect("./Main.me");
		  }
		%>
		
		<div class="member-join">
		<div class="container">
		<div class="section section-text">
			<div class="row">
				<div class="col-md-9 ml-auto mr-auto">
				<div class="col-md-6 ml-auto mr-auto">
				<h3 class="title memberup" >주스 트럭 회원 가입</h3>
				</div>
				<form method="post" action="./JoinAction.me" enctype="multipart/form-data" id="fr" onsubmit="return validate();">
				<div class="memberup">
			<div>
				<img id="imgPre" src="./person.png" width="150" height="150" alt="Circle Image" class="img-raised rounded-circle memberbtn image5">
			</div>
			<div>
				<span class="btn btn-primary btn-fab btn-fab-mini btn-file btn-round">
					<span class="fileinput-exists"> 
						<i class="material-icons">image</i>
					</span> 
						<input type="file" name="user_img" id="user_img">
				</span>
			</div>
			</div>
			
			
			
				
				<label for="exampleFormControlTextarea1">이메일</label><br>
				<input type="email" class="form-control maintext" name="email" id="email" placeholder="이메일을 입력하세요"> <div id="msg" class="log"> </div>
				<input type="button" class="btn btn-primary" value="중복체크" id="chk"> 
				<!-- <div id="msg"> </div> -->
				
				
				<br>
				<br>
				<label for="exampleFormControlTextarea1" >비밀번호</label>	
				<input type="password" class="form-control maintext" placeholder="8~20자 이내 영문,대/소문자,숫자만 가능" name="pass" id="pass" maxlength="20"><br>
				<br>
				<label for="exampleFormControlTextarea1" >비밀번호 확인</label>	
				<input type="password" class="form-control maintext" placeholder="8~20자 이내 영문,대/소문자,숫자만 가능" name="pass2" id="pass2" maxlength="20"><br>
				
				<br>
				<label for="exampleFormControlTextarea1" >이름</label>	
				<input type="text" class="form-control maintext" placeholder="이름을 입력하세요" name="name" id="name" maxlength="10"><br>
				
				<br>
				<label for="exampleFormControlTextarea1" >닉네임</label>	
				<input type="text" class="form-control maintext" placeholder="특수문자 사용 불가(2~10자이내)" name="nick" id="nick" maxlength="10">
				<div id="msg2" class="log"> </div>
				<input type="button" class="btn btn-primary" value="중복확인" id="ckn"> 
				<br>
				
				<br>
				<label for="exampleFormControlTextarea1" >전화번호</label>	
				<input type="text" class="form-control maintext" placeholder="'-'를 제외한 숫자만 입력하세요" name="phone" id="phone" maxlength="11">
				<input type="button" class="btn btn-primary" value="인증하기" id="pck" onclick="doTimer()"><br>
				<input type="text" class="form-control maintext" name="number" id="number" maxlength="6" placeholder="인증번호를 입력하세요">
				<input type="hidden" name="num_check" id="num_check">
				<input type="button" class="btn btn-primary" value="인증완료" id="pckcom" onclick="doCodeCheck();"><br>	
				<input type="text"  id="timer" name="timer" value="" style="background-color: white; border: none;" readonly><br>
				
				<br>
				<label for="exampleFormControlTextarea1" >주소</label>		
				<input type="text" class="form-control maintext" id="zip" name="zip" placeholder="우편번호" readonly>
				<input type="button" class="btn btn-primary" onclick="Postcode();" value="우편번호 찾기"><br>
				<input type="text" class="form-control maintext" id="addr" name="addr" placeholder="주소를 입력하세요"><br>
				<span id="guide" style="color:#999;display:none"></span>
				<input type="text"  class="form-control maintext" id="addr2" name="addr2"  placeholder="상세주소를 입력하세요"><br>
				
					
				<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
				<script>
				 function Postcode() {
				        new daum.Postcode({
				            oncomplete: function(data) {
				                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
			
				                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
				                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				                var addr = data.roadAddress; // 도로명 주소 변수
				                var extraRoadAddr = ''; // 참고 항목 변수
			
				                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
				                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
				                    extraRoadAddr += data.bname;
				                }
				                // 건물명이 있고, 공동주택일 경우 추가한다.
				                if(data.buildingName !== '' && data.apartment === 'Y'){
				                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
				                }
				                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
				                if(extraRoadAddr !== ''){
				                    extraRoadAddr = ' (' + extraRoadAddr + ')';
				                }
			
				                // 우편번호와 주소 정보를 해당 필드에 넣는다.
				                document.getElementById('zip').value = data.zonecode;
				                document.getElementById("addr").value = addr;
				                document.getElementById('addr2').focus();
				                
				                var guideTextBox = document.getElementById("guide");
				                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
				                if(data.autoRoadAddress) {
				                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
				                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
				                    guideTextBox.style.display = 'block';
			
				                } else if(data.autoJibunAddress) {
				                    var expJibunAddr = data.autoJibunAddress;
				                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
				                    guideTextBox.style.display = 'block';
				                } else {
				                    guideTextBox.innerHTML = '';
				                    guideTextBox.style.display = 'none';
				                }
				            }
				        }).open();
				    }
				</script>
				<div class="col-md-5 ml-auto mr-auto fileadd6">
				<input type="submit" class="btn btn-primary" value="회원가입" >
				<input type="button" class="btn btn-primary" value="돌아가기" onclick="history.back();">
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