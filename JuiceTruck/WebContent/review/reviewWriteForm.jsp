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
		
		<%
		  String nick = (String) session.getAttribute("nick");
		  String w_nick = nick;
		%>
<div class="main main-raised">
	<div class="container">
		<div class="section section-text">
			<div class="row">
				<div class="col-md-9 ml-auto mr-auto">
					<h3 class="title">리뷰등록 페이지</h3>		
		   
		   <form action="./reviewWriteAction.re" method="post" enctype="multipart/form-data" name="fr" onsubmit="return check();">
		   <input type="hidden" name="re_star" id="re_star" value="">  
		        <div class="col">
		        <label for="exampleFormControlTextarea1" >판매자</label>
					<input type="text" class="form-control maintext" name="s_nick" value="<%=request.getParameter("s_nick") %>" readonly>
					<input type="hidden" class="form-control maintext" name="w_nick" value="<%=w_nick %>" readonly>
				</div>
		        
		        <!-- 이미지 클릭시 id값을 넘겨줄것 -->
		        <!-- 자바스크립트를 통해 클릭시 이미지 변경 -->
		        
		        	<label for="exampleFormControlTextarea1" class="rews">별점</label>
		        	<div>
		        	  <i class="material-icons starpoint" id="1">star_outline</i>
		        	  <i class="material-icons starpoint" id="2">star_outline</i>
		        	  <i class="material-icons starpoint" id="3">star_outline</i>
		        	  <i class="material-icons starpoint" id="4">star_outline</i>
		        	  <i class="material-icons starpoint" id="5">star_outline</i>
		        	</div>
		        
			        <label for="exampleFormControlTextarea1" class="rews">첨부 파일</label>
			          <!-- 이미지 파일만 업로드 가능하게 구현 --> 
			         <div> 
			          <input type="file" name="file" accept="image/*">
		             </div>
				<div class="form-group dt2">
					<label for="exampleFormControlTextarea1" >상세 사항</label>
					<textarea class="form-control maintext" id="exampleFormControlTextarea1" name="re_content"
						rows="10" maxlength="600" placeholder="판매자에 대한 리뷰를 입력하세요. 최대 600자" required></textarea>
				</div>		        
		        
		        <div class="col-md-5 ml-auto mr-auto fileadd6">
					<input type="submit" class="btn btn-primary" value="리뷰 등록">
					<input type="reset" class="btn btn-primary" value="초기화">
									
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
