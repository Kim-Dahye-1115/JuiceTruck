<!-- 
(관리자)문의 답변 작성 페이지
원글의 카테고리 자동선택
내용에 원글의 내용이 포함됨
name값
	email(이메일)
	content(글내용)
	category(카테고리)
	subject(제목)
	num(글번호)
	nick(nick)
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
				
				//제목(33자)/내용666자 길이 체크
				if(subject.length>33){
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
		
		<h2>고객센터</h2>
		<!-- 페이지 이동-->
		<a href="./qnaWrite.qa">문의하기</a> 
		<a href="./qnaList.qa">문의내역</a> 
		<!-- 페이지 이동-->
			
		<%
		//request.setAttribute("qnaContent", qdao.getQnaContent(num));
		QnaBean qb = (QnaBean) request.getAttribute("qnaContent");
		String cate=qb.getQ_category();
		%>
		<!-- 본문 폼 -->
		<form action="./AdminQnaWriteAction.qa" method="post" name="fr" onsubmit="return check();">
			<input type="hidden" value="<%=qb.getQ_num() %>" name="num">
			<table>
			<!-- 카테고리 -->
				<tr>
			   		<td>
					    <select name="category">
						    <option value="계정문의" <%if(cate.equals("계정문의")){ %>selected="selected"<%} %> >계정문의</option>
						    <option value="이용문의" <%if(cate.equals("이용문의")){ %>selected="selected"<%} %> >이용문의</option>
						    <option value="기타" <%if(cate.equals("기타")){ %>selected="selected"<%} %> >기타</option>
					    </select>
			    	</td>
				</tr>
			<!-- 카테고리 -->
				<tr>
				    <td>
						<input type="text" name="subject" maxlength="33" placeholder="제목을 입력하세요(15자이내)">
			   		</td>
				</tr>
				<tr>
					<td>
						<h5 id="contentSize"></h5>
			   		</td>   	
				</tr>		
				<tr>
				    <td>
			    	<textarea rows="20" name="content">-문의내용-&#10;<%=qb.getQ_content() %></textarea>
			   		</td>
				</tr>
			</table>
			
			<input type="submit" value="답변하기">
		</form>
		<!-- 본문 폼 -->
		
		<!-- 푸터 -->
		<jsp:include page="../inc/bottom.jsp"/>
		<!-- 푸터 -->
	
	</body>
</html>