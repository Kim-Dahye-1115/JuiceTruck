<%@page import="com.market.db.ReviewBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
		<script type="text/javascript">
			// 자바스크립트 중 젤밑에 있던 유효성 체크 위로 옮김 
			/* 유효성 체크 */
			function check() {
			// 변수 선언 - 추가함
			var fileName = document.getElementById("inputFile").value;
			// 변수 선언 - 추가함
			
				// 닉네임 체크
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
				
				// 별점 미선택 체크
				if(document.fr.re_star.value == ""){
					alert("별점을 선택해주세요");
					return false; 
				}
				
				// 리뷰 내용 공백 체크
				if(document.fr.re_content.value == ""){
					alert("리뷰내용을 입력해주세요");
					document.fr.re_content.focus();
					return false;
				}
				
				// 유효성 체크
				// 업로드 파일 확장자 제어 (jpg,jpeg,png,gif) - 추가한 부분
				if(!(fileName.substr(fileName.length-3)=="jpg" || fileName.substr(fileName.length-3)=="png" || fileName.substr(fileName.length-3) =="gif" || fileName.substr(fileName.length-4)=="jpeg" || fileName=="" )){
					alert("jpg,jpeg,png,gif 파일만 첨부 가능합니다");
					return false;
				}
				// 업로드 파일 확장자 제어 (jpg,jpeg,png,gif) - 추가한 부분
			}
			// 자바스크립트 중 젤밑에 있던 유효성 체크 위로 옮김 
			
			/* 별점 이미지 변경 로직 */
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
			
			
			// 업로드 이미지 미리보기 - 추가한 부분
		    $(function() {
		        $("#inputFile").on('change', function(){
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
		   // 업로드 이미지 미리보기 - 추가한 부분
			
			  
		</script>
	</head>
	
	<body>
		<!-- 헤더 -->
		<jsp:include page="../inc/top.jsp"/>
		<!-- 헤더 -->
<div class="main main-raised">
	<div class="container">
		<div class="section section-text">
			<div class="row">
				<div class="col-md-9 ml-auto mr-auto">
					<h2 class="title">리뷰등록 페이지</h2>
		
			<%  
				ReviewBean rb = (ReviewBean)request.getAttribute("rb");
			    String w_nick = (String) session.getAttribute("nick");
			%>
		   
		   <form action="./reviewUpdateProAction.re" method="post" enctype="multipart/form-data" name="fr" onsubmit="return check();">
		   <input type="hidden" name="re_star" id="re_star" value="<%=rb.getRe_star()%>">
		   <input type="hidden" name="re_num" value="<%=rb.getRe_num() %>">  
			          <!-- 닉네임은 readonly타입으로 수정 불가능하게 구현 
			          	   value는 표현식으로 적용해야함-->
		         <div class="col">
		        	<label for="exampleFormControlTextarea1" >판매자</label>
					<input type="text" class="form-control maintext" name="s_nick" value="<%=rb.getS_nick() %>" readonly>
					<input type="hidden" class="form-control maintext" name="w_nick" value="<%=w_nick %>" readonly>
				</div>
		         
		        
		        <label for="exampleFormControlTextarea1" class="rews">별점</label>
			      <div>   <!-- 반복문 이용하여 전달받은 id값만큼 이미지 표시함 -->
			         <% for(int j=1;j<=rb.getRe_star();j++){ %>
					     <i class="material-icons starpoint" id="<%=j %>">star</i>
					 <%
					   }
					  for(int j=rb.getRe_star()+1;j<=5;j++){ %>
					     <i class="material-icons starpoint" id="<%=j %>">star_outline</i>
					 <%
					   }
					 %>
			       </div>
		        
		         <label for="exampleFormControlTextarea1" class="rews">첨부 파일</label>
			          <!-- 처음 작성 때 첨부한 이미지 표시 -->
			          <!-- id="imgPre"추가, onclick 추가, 파일 사이즈 제어 width,height추가 -->
			         <div>
			          <img id="imgPre" src="./upload/<%=rb.getFile()%>" onclick="document.fr.file.click();" width="200" height="200">
			          <!-- 이미지 파일만 업로드 가능하게 구현 --> 
			          <!-- id="inputFile" name="inputFile" 추가 -->
			         </div>
			          <input type="file" id="inputFile" name="inputFile" accept="image/*">
			          
		        <div class="form-group dt2">
					<label for="exampleFormControlTextarea1" >상세 사항</label>
					<textarea class="form-control maintext" id="exampleFormControlTextarea1" name="re_content"
						rows="10" maxlength="600" placeholder="판매자에 대한 리뷰를 입력하세요. 최대 600자" required><%=rb.getRe_content() %></textarea>
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
