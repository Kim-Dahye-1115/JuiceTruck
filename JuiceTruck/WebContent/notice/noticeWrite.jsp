<!-- 
(관리자) 공지사항 작성 페이지
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	</head>
	<body>
		<script type="text/javascript" src="http://code.jquery.com/jquery-3.5.1.js"></script>
		<script type="text/javascript">
			//유효성 검사, 제목/내용 길이 제한
			function check(){
				var title = document.fr.title.value;
				var content = document.fr.content.value;
		 		
				//제목 공백 체크
				if(title == ""){
					alert("제목을 입력하세요");
					return false;
				}
				//내용 공백 체크
				if(content == ""){
					alert("내용을 입력하세요");
					return false;
				}
				
				//제목(100자)/내용2000자 길이 체크
				if(title.length>100){
					alert("제목 글자수 초과");
					return false;
				}
				if(content.length>2000){
					alert("내용 글자수 초과");
					return false;
				}
						
				return true;
			}
			
			//내용 글자수 보기
			$(function(){
				$('textarea').keyup(function(){
					var size = 2000;
					var v = $(this).val().length;
					//alert("v"+v);
					if((size-v) >= 0 ){
						$('#contentSize').val(size-v);
					}
					else{
						$('#contentSize').val("가능한 글자수를 초과했습니다.");
					}
				});
				
			});
		
		</script>
		
		<!-- 헤더 -->
		<jsp:include page="../inc/top.jsp"/>
		<!-- 헤더 -->
<div class="main main-raised">
	<div class="container">
		<div class="section section-text">
			<div class="row">
 				<div class="col-md-9 ml-auto mr-auto"> 
					<h3 class="title">공지사항</h3>
					<!-- 본문 폼 -->
					<form action="./noticeWriteAction.no" method="post" name="fr" onsubmit="return check();">
						<input type="text" class="form-control maintext" name="title" maxlength="100" placeholder="제목을 입력하세요">
						<label for="exampleFormControlTextarea1">글자수 제한</label>
						<input type="text" class="log adminTextHide" value="2000" id="contentSize" readonly>
						<div class="form-group dt2">
			    			<textarea class="form-control maintext" rows="20" name="content" placeholder="내용을 입력하세요"></textarea>
						</div>
						<!-- 서브밋 버튼 -->
						<div class="col-md-2 ml-auto mr-auto fileadd6">
							<input type="submit" value="등록" class="btn btn-primary">
						</div>
						<!-- 서브밋 버튼 -->
					</form>
					<!-- 본문 폼 끝 -->
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