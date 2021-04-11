<!-- 상품 등록 페이지입니다. -->
<%@page import="com.member.db.MemberBean"%>
<%@page import="com.member.db.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<!-- 헤더 -->
<jsp:include page="../inc/top.jsp"/>
<!-- 헤더 -->

<%
	String email = (String) session.getAttribute("email");
	
	MemberDAO mdao = new MemberDAO();
	MemberBean mb = mdao.getMember(email);

%>
<div class="main main-raised">
	<div class="container">
		<div class="section section-text">
			<div class="row">
				<div class="col-md-9 ml-auto mr-auto">
					<h3 class="title">상품 등록하기</h3>
						
						<!-- 폼 시작 -->
						<form action="./GoodsAddAction.ag" method="post" enctype="multipart/form-data">
						
							<input type="hidden" name="nick" value="<%=mb.getNick() %>">
							<input type="hidden" name="location" value="<%=mb.getAddr() %>">
							<label for="exampleFormControlTextarea1">상품 이미지 첨부</label>
							
							<!-- 파일첨부 영역 시작 -->
							<div class="fileadd6">
							
								<!-- 파일첨부버튼(0) -->
								<div class="fileinput fileinput-new text-center" data-provides="fileinput">
									<div class="fileinput-new thumbnail img-raised"></div>
									  <div class="fileinput-preview fileinput-exists thumbnail img-raised image3"></div>
										<div>
										  <span	class="btn btn-primary btn-fab btn-fab-mini btn-file btn-round">
											<button class="fileinput-new">
												<i class="material-icons">add_photo_alternate</i>
											</button> 
											    <span class="fileinput-exists">
												  <i class="material-icons">image</i>
												</span>
											<!-- 파일 인풋 버튼 (0)-->	 
											<input id="file0" type="file" name="file0" accept="image/*" required>
										  </span> 
										    <a href="#pablo"
											class="btn btn-danger btn-fab btn-fab-mini btn-round fileinput-exists"
											data-dismiss="fileinput">
											  <i class="fa fa-times"></i>
											</a>
									    </div>
								</div>
								<!-- 파일첨부버튼(1) -->
								<div class="fileinput fileinput-new text-center" data-provides="fileinput">
									<div class="fileinput-new thumbnail img-raised"></div>
									  <div class="fileinput-preview fileinput-exists thumbnail img-raised image3"></div>
										<div>
										  <span	class="btn btn-primary btn-fab btn-fab-mini btn-file btn-round">
											<button class="fileinput-new">
												<i class="material-icons">add_photo_alternate</i>
											</button> 
											    <span class="fileinput-exists">
												  <i class="material-icons">image</i>
												</span>
											<!-- 파일 인풋 버튼 (1)-->	 
											<input type="file" name="file1" accept="image/*">
										  </span>  
										    <a href="#pablo"
											class="btn btn-danger btn-fab btn-fab-mini btn-round fileinput-exists"
											data-dismiss="fileinput">
											  <i class="fa fa-times"></i>
											</a>
									    </div>
								</div>
								<!-- 파일첨부버튼(2) -->
								<div class="fileinput fileinput-new text-center" data-provides="fileinput">
									<div class="fileinput-new thumbnail img-raised"></div>
									  <div class="fileinput-preview fileinput-exists thumbnail img-raised image3"></div>
										<div>
										  <span	class="btn btn-primary btn-fab btn-fab-mini btn-file btn-round">
											<button class="fileinput-new">
												<i class="material-icons">add_photo_alternate</i>
											</button> 
											    <span class="fileinput-exists">
												  <i class="material-icons">image</i>
												</span>
											<!-- 파일 인풋 버튼 (2)-->	 
											<input type="file" name="file2" accept="image/*">
										  </span> 
										    <a href="#pablo"
											class="btn btn-danger btn-fab btn-fab-mini btn-round fileinput-exists"
											data-dismiss="fileinput">
											  <i class="fa fa-times"></i>
											</a>
									    </div>
								</div>
								<!-- 파일첨부버튼(3) -->
								<div class="fileinput fileinput-new text-center" data-provides="fileinput">
									<div class="fileinput-new thumbnail img-raised"></div>
									  <div class="fileinput-preview fileinput-exists thumbnail img-raised image3"></div>
										<div>
										  <span	class="btn btn-primary btn-fab btn-fab-mini btn-file btn-round">
											<button class="fileinput-new">
												<i class="material-icons">add_photo_alternate</i>
											</button> 
											    <span class="fileinput-exists">
												  <i class="material-icons">image</i>
												</span>
											<!-- 파일 인풋 버튼 (3)-->	 
											<input type="file" name="file3" accept="image/*">
										  </span> 
										    <a href="#pablo"
											class="btn btn-danger btn-fab btn-fab-mini btn-round fileinput-exists"
											data-dismiss="fileinput">
											  <i class="fa fa-times"></i>
											</a>
									    </div>
								</div>
								<!-- 파일첨부버튼(4) -->
								<div class="fileinput fileinput-new text-center" data-provides="fileinput">
									<div class="fileinput-new thumbnail img-raised"></div>
									  <div class="fileinput-preview fileinput-exists thumbnail img-raised image3"></div>
										<div>
										  <span	class="btn btn-primary btn-fab btn-fab-mini btn-file btn-round">
											<button class="fileinput-new">
												<i class="material-icons">add_photo_alternate</i>
											</button> 
											    <span class="fileinput-exists">
												  <i class="material-icons">image</i>
												</span>
											<!-- 파일 인풋 버튼 (4)-->	 
											<input type="file" name="file4" accept="image/*">
										  </span> 
										    <a href="#pablo"
											class="btn btn-danger btn-fab btn-fab-mini btn-round fileinput-exists"
											data-dismiss="fileinput">
											  <i class="fa fa-times"></i>
											</a>
									    </div>
								</div>
								<!-- 파일첨부버튼(5) -->
								<div class="fileinput fileinput-new text-center" data-provides="fileinput">
									<div class="fileinput-new thumbnail img-raised"></div>
									  <div class="fileinput-preview fileinput-exists thumbnail img-raised image3"></div>
										<div>
										  <span	class="btn btn-primary btn-fab btn-fab-mini btn-file btn-round">
											<button class="fileinput-new">
												<i class="material-icons">add_photo_alternate</i>
											</button> 
											    <span class="fileinput-exists">
												  <i class="material-icons">image</i>
												</span>
											<!-- 파일 인풋 버튼 (5)-->	 
											<input type="file" name="file5" accept="image/*">
										  </span> 
										    <a href="#pablo"
											class="btn btn-danger btn-fab btn-fab-mini btn-round fileinput-exists"
											data-dismiss="fileinput">
											  <i class="fa fa-times"></i>
											</a>
									    </div>
								</div>
							</div>
							<!-- 파일첨부 영역 끝 -->


							<!-- 제목 -->	
							<div class="col dt2">
							  <label for="exampleFormControlTextarea1" >*이미지는 정방형으로 크롭됩니다.</label>
								<input type="text" class="form-control maintext" placeholder="제목을 입력하세요.최대 21자" name="g_name" maxlength="21" required>
							</div>
							
							<!-- 카테고리 셀렉트 -->
							<div class="form-group">
								<select class="form-control selectpicker"
									data-style="btn btn-link" id="exampleFormControlSelect1" name="category" required>
									<option selected disabled>상품 카테고리</option>
									<option value="여성의류">여성의류</option>
									<option value="남성의류">남성의류</option>
									<option value="패션잡화">패션잡화</option>
									<option value="디지털/가전">디지털/가전</option>
									<option value="음반/도서/티켓">음반/도서/티켓</option>
									<option value="생활/취미">생활/취미</option>
									<option value="동물 용품">동물 용품</option>
									<option value="뷰티/미용">뷰티/미용</option>
									<option value="아동 용품">아동 용품</option>
									<option value="나눔">나눔</option>
								</select>
							</div>
							
							<!-- 상품 상태 -->
							<div class="form-group">
								<select class="form-control selectpicker"
									data-style="btn btn-link" id="exampleFormControlSelect1" name="condi" required>
									<option selected disabled>상품 상태</option>
									<option>새 것</option>
									<option>중고</option>
									<option value="거래 완료" disabled>거래 완료 (글수정 시 선택 가능합니다.)</option>
								</select>
							</div>
							
							<!-- 네고 여부 -->
							<div class="form-group">
								<select class="form-control selectpicker"
									data-style="btn btn-link" id="exampleFormControlSelect1" name="nego" required>
									<option selected disabled>네고 가능 여부</option>
									<option value="가능">가능</option>
									<option value="불가">불가</option>
								</select>
								</select>
							</div>
							
							<!-- 가격 -->
							<div class="col">
								<input type="number" class="form-control maintext" placeholder="가격을 입력하세요" name="price" required>
							</div>
							
							<!-- 상세 사항 -->
							<div class="form-group dt2">
								<label for="exampleFormControlTextarea1" >상세 사항</label>
								<textarea class="form-control maintext" id="exampleFormControlTextarea1" name="content"
									rows="10" maxlength="1000" placeholder="상품 설명을 입력하세요. 최대 1000자" required></textarea>
							</div>
							
							<!-- 서브밋 버튼 -->
							<div class="col-md-5 ml-auto mr-auto fileadd6">
								<input type="submit" class="btn btn-primary" value="등록 하기">
								<input type="reset" class="btn btn-primary" value="취소 하기">
									
							</div>
						</form>
						<!-- 폼 끝 -->

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