<!-- 
(관리자)문의 답변 작성 페이지
-->
<%@page import="com.admin.db.QnaBean"%>
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
		//제목, 내용, 파일사이즈, 파일 확장자 유효성 검사, 제목/내용 길이 제한, 업로드 이미지 미리보기
	function check(){
		var subject = document.fr.subject.value;
		var content = document.fr.content.value;
	
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
		
		//제목(100자)/내용2000자 길이 체크
		if(subject.length>100){
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
					<h2 class="title">고객센터</h2>
					<%
					//request.setAttribute("qnaContent", qdao.getQnaContent(num));
					QnaBean qb = (QnaBean) request.getAttribute("qnaContent");
					String cate=qb.getQ_category();
					%>
					<!-- 본문 폼 -->
					<form action="./AdminQnaWriteAction.qa" method="post" name="fr" onsubmit="return check();">
						<input type="hidden" value="<%=qb.getQ_num() %>" name="num">
							<!-- 카테고리 -->
							<div class="form-group">
							    <select name="category" class="form-control selectpicker" data-style="btn btn-link">
								    <option value="계정문의" <%if(cate.equals("계정문의")){ %>selected="selected"<%} %> >계정문의</option>
								    <option value="이용문의" <%if(cate.equals("이용문의")){ %>selected="selected"<%} %> >이용문의</option>
								    <option value="기타" <%if(cate.equals("기타")){ %>selected="selected"<%} %> >기타</option>
							    </select>
							</div>
							<!-- 카테고리 -->
						<input type="text" class="form-control maintext" name="subject" maxlength="100" placeholder="제목을 입력하세요">
						<label for="exampleFormControlTextarea1">글자수 제한</label>
						<input type="text" value="" class="log adminTextHide" id="contentSize" readonly>
				    	<div class="form-group dt2">
				    		<textarea rows="20" name="content" class="form-control maintext">-문의내용-&#10;<%=qb.getQ_content() %>&#10;ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ&#10;답변:</textarea>
				    	</div>
				    	
						<div class="col-md-3 ml-auto mr-auto fileadd6">
							<input type="submit" value="답변하기" class="btn btn-primary">
						</div>
					</form>
					<!-- 본문 폼 -->
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