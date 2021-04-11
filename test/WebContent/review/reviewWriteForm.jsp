<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
		<script type="text/javascript">
			/* 별점 이미지 로직 */
			$(function() {
				/* img파일에 클릭이벤트 발생 시 이미지 태그의 id값을 저장 */
				$('.material-icons').click(function(){
				    var star_id = $(this).attr("id");
				    
				    document.getElementById('re_star').value = star_id;
				    
				    /* 반복문 이용 - 이미지 변경 */
				    switch(star_id){
					  case "1":
						  $("#1").html("star");
						  $("#2,#3,#4,#5").html("star_outline");
						  break;
					  case "2":
						  $("#1,#2").html("star");
						  $("#3,#4,#5").html("star_outline");
						  break;
					  case "3":
						  $("#1,#2,#3").html("star");
						  $("#4,#5").html("star_outline");
						  break;
					  case "4":
						  $("#1,#2,#3,#4").html("star");
						  $("#5").html("star_outline");
						  break;
					  case "5":
						  $("#1,#2,#3,#4,#5").html("star");
						  break;
					  default :
						  $("#1,#2,#3,#4,#5").html("star_outline");
					  	break;
					  }
			
				});
			});
			
			/* 유효성 체크 */
			function check() {
				if(document.fr.s_nick.value == ""){
					alert("판매자 닉네임을 확인해주세요");
					document.fr.s_nick.focus();
					return false;
				}
				
				if(document.fr.w_nick.value == ""){
					alert("작성자 닉네임을 확인해주세요");
					document.fr.w_nick.focus();
					return false;
				}
			
				if(document.fr.re_star.value == ""){
					alert("별점을 선택해주세요");
					return false; 
				}
				
				
				if(document.fr.re_content.value == ""){
					alert("리뷰내용을 입력해주세요");
					document.fr.re_content.focus();
					return false;
				}
			}
		
		</script>
	</head>
	
	<body>
		<!-- 헤더 -->
		<jsp:include page="../inc/top.jsp"/>
		<!-- 헤더 -->
		<br><br><br><br><br><br>
		
		<%
		  String nick = (String) session.getAttribute("nick");
		%>
		
		<h2> 리뷰등록 페이지 </h2>
		   
		   <form action="./reviewWriteAction.re" method="post" enctype="multipart/form-data" name="fr" onsubmit="return check();">
		   <input type="hidden" name="re_star" id="re_star" value="">  
		     <table border="1">
		        <tr>
		        	<td>
		        	  <!-- 판매자 이미지 가져오기 -->
		        	  <img alt="판매자 이미지" src="" >
		        	</td>
			        <td>
			          <input type="text" name="s_nick" value="에이" readonly>
			        </td>
		        </tr>
		        <tr>
		        	<td>
		        	  <!-- 작성자 이미지 가져오기 -->
		        	  <img alt="작성자 이미지" src="">
		        	</td>
			        <td>
			          <input type="text" name="w_nick" value="<%=nick %>" readonly>
			        </td>
		        </tr>
		        
		        <!-- 이미지 클릭시 id값을 넘겨줄것 -->
		        <!-- 자바스크립트를 통해 클릭시 이미지 변경 -->
		        <tr>
		        	<td>별점</td>
		        	<td>
		        	  <i class="material-icons" id="1">star_outline</i>
		        	  <i class="material-icons" id="2">star_outline</i>
		        	  <i class="material-icons" id="3">star_outline</i>
		        	  <i class="material-icons" id="4">star_outline</i>
		        	  <i class="material-icons" id="5">star_outline</i>
		        	</td>
		        </tr>
		        
		        <tr>
			        <td>첨부 파일</td>
			        <td>
			          <!-- 이미지 파일만 업로드 가능하게 구현 --> 
			          <input type="file" name="file" accept="image/*">
			        </td>
		        </tr>
		        
		        <tr>
			        <td>리뷰내용</td>
			        <td>
			          <textarea rows="20" cols="40" name="re_content" maxlength="150"></textarea>
			        </td>
		        </tr>
		        
		        <tr>
			        <td colspan="2">
			          <input type="submit" value="리뷰등록">
			          <input type="reset" value="초기화">
			        </td>
		        </tr>
		     </table>  
		   </form>
		
		<!-- 푸터 -->
		<jsp:include page="../inc/bottom.jsp"/>
		<!-- 푸터 -->
	</body>
</html>
