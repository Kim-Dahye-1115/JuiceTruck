<!-- 
(관리자) 공지사항 작성 페이지
name값 
	content(글내용)
	title(제목)
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
				
				//제목(33자)/내용666자 길이 체크
				if(title.length>33){
					alert("제목 글자수 초과");
					return false;
				}
				if(content.length>666){
					alert("내용 글자수 초과");
					return false;
				}
						
				return true;
			}
			
			//내용 글자수 보기
			$(function(){
				$('textarea').keyup(function(){
					var size = 666;
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
		
		</script>
		
		<!-- 헤더 -->
		<jsp:include page="../inc/top.jsp"/>
		<!-- 헤더 -->
		<br><br><br><br><br><br>
		
		<h2>공지사항</h2>
		<!-- 본문 폼 -->
		<form action="./noticeWriteAction.no" method="post" name="fr" onsubmit="return check();">
			<table>
				<tr>
				    <td>
						<input type="text" name="title" maxlength="33" placeholder="제목을 입력하세요(15자이내)">
			   		</td>
				</tr>
				<tr>
					<td>
						<h5 id="contentSize">666</h5>
			   		</td>   	
				</tr>	
				<tr>
				    <td>
			    		<textarea rows="20" name="content" placeholder="내용을 입력하세요"></textarea>
			   		</td>
				</tr>
			</table>
			<!-- 테이블 -->
			
			<!-- 서브밋 버튼 -->
			<input type="submit" value="등록">
			<!-- 서브밋 버튼 -->
		</form>
		<!-- 본문 폼 끝 -->
		
		<!-- 푸터 -->
		<jsp:include page="../inc/bottom.jsp"/>
		<!-- 푸터 -->
	</body>
</html>