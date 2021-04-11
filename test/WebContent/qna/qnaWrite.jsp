<!-- 
문의글 작성 페이지
문의하기 링크와 연결됨
업로드 이미지 미리보기
name값 
	file(파일)
	content(글내용)
	category(카테고리)
	subject(제목)
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	</head>
	<body>
		<!-- http://code.jquery.com/jquery-3.5.1.js -->
		<!-- ../js/jquery-3.5.1.js -->
		<script type="text/javascript" src="http://code.jquery.com/jquery-3.5.1.js"></script>
		<script type="text/javascript">
			//제목, 내용, 파일사이즈, 파일 확장자 유효성 검사, 제목/내용 길이 제한, 업로드 이미지 미리보기
			function check(){
				var subject = document.fr.subject.value;
				var content = document.fr.content.value;
				var fileName = document.getElementById("inputFile").value;
				var maxSize = 10*1024*1024; //10MB
				var imgFile = $('#inputFile').val();
				
				//제목 공백 체크
				if(subject == ""){
					alert("제목을 입력하세요");
					return false;
				}
				//내용 공백 체크
				if(content == ""){
					alert("내용을 입력하세요");
					return false;
				}
				
				//파일이있을때
				if(imgFile != "" && imgFile != null){
					var fileSize = document.getElementById("inputFile").files[0].size;
					if(fileSize>maxSize) {
				    	alert("파일 크기는 10MB까지 가능합니다.");
				        return false;
				    }
				}
				
				//업로드 파일 확장자 제어 (jpg,jpeg,png,gif)
				if(!(fileName.substr(fileName.length-3)=="jpg" || fileName.substr(fileName.length-3)=="png" || fileName.substr(fileName.length-3) =="gif" || fileName.substr(fileName.length-4)=="jpeg" || fileName=="" )){
					alert("jpg,jpeg,png,gif 파일만 첨부 가능합니다");
					return false;
				}
				
				//제목(33자)/내용329자 길이 체크
				if(subject.length>33){
					alert("제목 글자수 초과");
					return false;
				}
				if(content.length>329){
					alert("내용 글자수 초과");
					return false;
				}
						
				return true;
			}
			
			//내용 글자수 보기
			$(function(){
				$('textarea').keyup(function(){
					var size = 329;
					var v = $(this).val().length;
					//alert("v"+v);
					if((size-v) >= 0 ){
						$('#contentSize').html(size-v);
					}
					else{
						$('#contentSize').html("가능한 글자수를 초과했습니다.");
					}
				});
				
			});
		
			// 업로드 이미지 미리보기
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
		  
		</script>
		<!-- 헤더 -->
		<jsp:include page="../inc/top.jsp"/>
		<!-- 헤더 -->
		<br><br><br><br><br><br>
		
		<h2>고객센터</h2>
		<!-- 페이지 이동 -->
		<a href="./qnaWrite.qa">문의하기</a> 
		<a href="./qnaList.qa">문의내역</a> 
		<!-- 페이지 이동 -->
		
		<!-- 본문 폼 -->
		<form action="./qnaWriteAction.qa" method="post" enctype="multipart/form-data" name="fr" onsubmit="return check();">
			<table>
			<!-- 상품 카테고리 선택  -->
				<tr>
			   		<td>
					   <select name="category" onchange="changes(document.fr.category.value)">
					   <option value="계정문의">계정문의</option>
					   <option value="이용문의">이용문의</option>
					   <option value="기타">기타</option>
					  </select>
			    	</td>
				</tr>
			<!-- 상품 카테고리 선택  -->
				<tr>
				    <td>
						<input type="text" name="subject" maxlength="33" placeholder="제목을 입력하세요(15자이내)">
			   		</td>
				</tr>
				<tr>
					<td>
						<h5 id="contentSize">329</h5>
			   		</td>   	
				</tr>	
				<tr>
				    <td>
			    		<textarea rows="20" name="content" placeholder="내용을 입력하세요"></textarea>
			   		</td>
				</tr>
			</table>
			<!-- 테이블 -->
			
			<!--input file(안보이게 css적용) -->
			<!-- 파일업로드,서브밋 버튼 -->
			<input type="file" accept="image/jpg, image/jpeg, image/png, image/gif" id="inputFile" name="file">
			<input type="button" value="사진첨부" onclick="document.fr.file.click();"> 
			<input type="submit" value="문의하기">
			<!-- 파일업로드,서브밋 버튼 -->
		</form>
		<!-- 본문 폼 끝 -->
		
		<!-- 업로드 이미지 미리보기 -->
		<img id="imgPre" src="#" alt="" onclick="document.fr.file.click();">
		
		<!-- 푸터 -->
		<jsp:include page="../inc/bottom.jsp"/>
		<!-- 푸터 -->
	
	</body>
</html>