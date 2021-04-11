<!-- 상품 등록 페이지입니다. -->
<%@page import="com.market.db.GoodsBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="http://code.jquery.com/jquery-3.5.1.js"></script>
<script type="text/javascript">


//이미지 미리보기
	    $(function() {
	        $("#file0").on('change', function(){
	            readURL(this);
	        });
	    });
	
	    function readURL(input) {
	        if (input.files && input.files[0]) {
	        var reader = new FileReader();
			
	        reader.onload = function (e) {
	                $('#imgPre0').attr('src', e.target.result);
	            }
	
	          reader.readAsDataURL(input.files[0]);
	        }
	    }
///////////////////////////////////////////////////////////////////////////	    
	    
	    $(function() {
	        $("#file1").on('change', function(){
	            readURL1(this);
	        });
	    });
	
	    function readURL1(input) {
	        if (input.files && input.files[0]) {
	        var reader = new FileReader();
			
	        reader.onload = function (e) {
	                $('#imgPre1').attr('src', e.target.result);
	            }
	
	          reader.readAsDataURL(input.files[0]);
	        }
	    }
 	    
///////////////////////////////////////////////////////////////////////////		    
	    $(function() {
	        $("#file2").on('change', function(){
	            readURL2(this);
	        });
	    });
	
	    function readURL2(input) {
	        if (input.files && input.files[0]) {
	        var reader = new FileReader();
			
	        reader.onload = function (e) {
	                $('#imgPre2').attr('src', e.target.result);
	            }
	
	          reader.readAsDataURL(input.files[0]);
	        }
	    }
	    
///////////////////////////////////////////////////////////////////////////		    
	    $(function() {
	        $("#file3").on('change', function(){
	            readURL3(this);
	        });
	    });
	
	    function readURL3(input) {
	        if (input.files && input.files[0]) {
	        var reader = new FileReader();
			
	        reader.onload = function (e) {
	                $('#imgPre3').attr('src', e.target.result);
	            }
	
	          reader.readAsDataURL(input.files[0]);
	        }
	    }
	    
///////////////////////////////////////////////////////////////////////////		    
	    $(function() {
	        $("#file4").on('change', function(){
	            readURL4(this);
	        });
	    });
	
	    function readURL4(input) {
	        if (input.files && input.files[0]) {
	        var reader = new FileReader();
			
	        reader.onload = function (e) {
	                $('#imgPre4').attr('src', e.target.result);
	            }
	
	          reader.readAsDataURL(input.files[0]);
	        }
	    }
	    
///////////////////////////////////////////////////////////////////////////		    
	    $(function() {
	        $("#file5").on('change', function(){
	            readURL5(this);
	        });
	    });
	
	    function readURL5(input) {
	        if (input.files && input.files[0]) {
	        var reader = new FileReader();
			
	        reader.onload = function (e) {
	                $('#imgPre5').attr('src', e.target.result);
	            }
	
	          reader.readAsDataURL(input.files[0]);
	        }
	    }
	       
	    
</script>
</head>
<body>
<!-- 헤더 -->
<jsp:include page="../inc/top.jsp"/>
<!-- 헤더 -->

<%

   GoodsBean gb = (GoodsBean) request.getAttribute("goodsbean");
%>   
<div class="main main-raised">
	<div class="container">
		<div class="section section-text">
			<div class="row">
				<div class="col-md-9 ml-auto mr-auto">
					<h3 class="title">글 수정하기</h3>
						
						<!-- 폼 시작 -->
						<form action="./GoodsModifyProAction.ag" method="post" enctype="multipart/form-data">
							 <input type="hidden" name="num" value="<%=gb.getG_num() %>" >
<%-- 							 <input type="hidden" name="oldfile" value="<%=gb.getImgs() %>"> --%>
							 <input type="hidden" name="oldfile0" value="<%=gb.getImgs().split(",")[0] %>" >
							 <input type="hidden" name="oldfile1" value="<%=gb.getImgs().split(",")[1] %>" >
							 <input type="hidden" name="oldfile2" value="<%=gb.getImgs().split(",")[2] %>" >
							 <input type="hidden" name="oldfile3" value="<%=gb.getImgs().split(",")[3] %>" >
							 <input type="hidden" name="oldfile4" value="<%=gb.getImgs().split(",")[4] %>" >
							 <input type="hidden" name="oldfile5" value="<%=gb.getImgs().split(",")[5] %>" >
							      
							<label for="exampleFormControlTextarea1">상품 이미지 첨부</label>
							
							<%=gb.getImgs().split(",")[0] %>
							
							<!-- 파일첨부 영역 시작 -->
							<div class="">
			<img id="imgPre0" src="./upload/<%=gb.getImgs().split(",")[0] %>" width="100" height="100"><br>
			<input type="file" name="file0" id="file0" accept="image/*" ><br>
									
			<img id="imgPre1" src="./upload/<%=gb.getImgs().split(",")[1] %>" width="100" height="100"><br>
			<input type="file" name="file1" id="file1" accept="image/*" ><br>	
									
 			<img id="imgPre2" src="./upload/<%=gb.getImgs().split(",")[2] %>" width="100" height="100"><br>
			<input type="file" name="file2" id="file2" accept="image/*" ><br>	
									
			<img id="imgPre3" src="./upload/<%=gb.getImgs().split(",")[3] %>" width="100" height="100"><br>
			<input type="file" name="file3" id="file3" accept="image/*" ><br>	
									
			<img id="imgPre4" src="./upload/<%=gb.getImgs().split(",")[4] %>" width="100" height="100"><br>
			<input type="file" name="file4" id="file4" accept="image/*" ><br>	
									
			<img id="imgPre5" src="./upload/<%=gb.getImgs().split(",")[5] %>" width="100" height="100"><br>
			<input type="file" name="file5" id="file5" accept="image/*" ><br>
										 
								<!-- 파일첨부버튼(0) -->
<!-- 								<div class="fileinput fileinput-new text-center" data-provides="fileinput">
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
											파일 인풋 버튼 (0)	 
											<input type="file" name="file0" accept="image/gif,image/jpeg,image/png"/>
										  </span> 
										    <a href="#pablo"
											class="btn btn-danger btn-fab btn-fab-mini btn-round fileinput-exists"
											data-dismiss="fileinput">
											  <i class="fa fa-times"></i>
											</a>
									    </div>
								</div>
								파일첨부버튼(1)
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
											파일 인풋 버튼 (1)	
											<input type="file" name="file1" />
										  </span> 
										    <a href="#pablo"
											class="btn btn-danger btn-fab btn-fab-mini btn-round fileinput-exists"
											data-dismiss="fileinput">
											  <i class="fa fa-times"></i>
											</a>
									    </div>
								</div>
								
								파일첨부버튼(2)
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
											파일 인풋 버튼 (2)	 
											<input type="file" name="file2" />
										  </span> 
										    <a href="#pablo"
											class="btn btn-danger btn-fab btn-fab-mini btn-round fileinput-exists"
											data-dismiss="fileinput">
											  <i class="fa fa-times"></i>
											</a>
									    </div>
								</div>
								
								파일첨부버튼(3)
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
										  파일 인풋 버튼 (3)
										  <input type="file" name="file3" />
										  </span> 
										    <a href="#pablo"
											class="btn btn-danger btn-fab btn-fab-mini btn-round fileinput-exists"
											data-dismiss="fileinput">
											  <i class="fa fa-times"></i>
											</a>
									    </div>
								</div>
								
								파일첨부버튼(4)
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
										  파일 인풋 버튼 (4)		
										  <input type="file" name="file4" />
										  </span> 
										    <a href="#pablo"
											class="btn btn-danger btn-fab btn-fab-mini btn-round fileinput-exists"
											data-dismiss="fileinput">
											  <i class="fa fa-times"></i>
											</a>
									    </div>
								</div>
								
								파일첨부버튼(5)
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
										  파일 인풋 버튼 (5)
										  <input type="file" name="file5" />
										  </span> 
										    <a href="#pablo"
											class="btn btn-danger btn-fab btn-fab-mini btn-round fileinput-exists"
											data-dismiss="fileinput">
											  <i class="fa fa-times"></i>
											</a>
									    </div>
								</div> -->
							</div>
							<!-- 파일첨부 영역 끝 -->


							<!-- 제목 -->
							<div class="col dt2">
							  <label for="exampleFormControlTextarea1" >*이미지는 정방형으로 크롭됩니다.</label>
								<input type="text" class="form-control maintext" placeholder="제목을 입력하세요.최대 21자" name="g_name" maxlength="21" 
								 	   value="<%=gb.getG_name() %>"	required>
							</div>
							
							<!-- 카테고리 셀렉트 -->
							<div class="form-group">
								<select class="form-control selectpicker"
									data-style="btn btn-link" id="exampleFormControlSelect1" name="category" required>
									<option selected>상품 카테고리</option>
									<option value="여성의류"
									<%if(gb.getCategory().equals("여성의류")){ %> selected
							        <%} %>
									>여성의류</option>
									
									<option value="남성의류"
									<%if(gb.getCategory().equals("남성의류")){ %>
							           selected
							           <%} %>
									>남성의류</option>
									
									<option value="패션잡화"
									<%if(gb.getCategory().equals("패션잡화")){ %>
							           selected
							           <%} %>
									>패션잡화</option>
									
									<option value="디지털/가전"
									<%if(gb.getCategory().equals("디지털/가전")){ %>
							           selected
							           <%} %>
									>디지털/가전</option>
									
									<option value="음반/도서/티켓"
									<%if(gb.getCategory().equals("음반/도서/티켓")){ %>
							           selected
							           <%} %>
									>음반/도서/티켓</option>
									
									<option value="생활/취미"
									<%if(gb.getCategory().equals("생활/취미")){ %>
							           selected
							           <%} %>
									>생활/취미</option>
									<option value="동물 용품"
									<%if(gb.getCategory().equals("동물 용품")){ %>
							           selected
							           <%} %>
									>동물 용품</option>
									
									<option value="뷰티/미용"
									<%if(gb.getCategory().equals("뷰티/미용")){ %>
							           selected
							           <%} %>
									>뷰티/미용</option>
									
									<option value="아동 용품"
									<%if(gb.getCategory().equals("아동 용품")){ %>
							           selected
							           <%} %>
									>아동 용품</option>
									
									<option value="나눔"
									<%if(gb.getCategory().equals("나눔")){ %>
							           selected
							           <%} %>
									>나눔</option>
								</select>
							</div>
							
							<!-- 상품 상태 -->
							<div class="form-group">
								<select class="form-control selectpicker"
									data-style="btn btn-link" id="exampleFormControlSelect1" name="condi" required>
									<option selected>상품 상태</option>
									<option value="새 것"
									<%if(gb.getCondi().equals("새 것")){ %>
							           selected
							           <%} %>
									>새 것</option>
									
									<option value="중고"
									<%if(gb.getCondi().equals("중고")){ %>
							           selected
							           <%} %>
									>중고</option>
								</select>
							</div>
							
							<!-- 네고 여부 -->
							<div class="form-group">
								<select class="form-control selectpicker"
									data-style="btn btn-link" id="exampleFormControlSelect1" name="nego" required>
									<option selected>네고 가능 여부</option>
									<option value="가능"
									<%if(gb.getNego().equals("가능")){ %>
							           selected
							           <%} %>
									>가능</option>
									
									<option value="불가"
									<%if(gb.getNego().equals("불가")){ %>
							           selected
							           <%} %>
									>불가</option>
								</select>
							</div>
							
							<!-- 가격 -->
							<div class="col">
								<input type="text" class="form-control maintext" placeholder="가격을 입력하세요" name="price"
										value="<%=gb.getPrice() %>" required>
							</div>
							
							<!-- 상세 사항 -->
							<div class="form-group dt2">
								<label for="exampleFormControlTextarea1" >상세 사항</label>
								<textarea class="form-control maintext" id="exampleFormControlTextarea1" name="content"
									rows="10" maxlength="1000" placeholder="상품 설명을 입력하세요. 최대 1000자" required><%=gb.getContent() %></textarea>
							</div>
							
							<!-- 서브밋 버튼 -->
							<div class="col-md-5 ml-auto mr-auto fileadd6">
								<input type="submit" class="btn btn-primary" value="등록 하기">
								<input type="reset" class="btn btn-primary" value="취소 하기">
									
									<!-- 임시 계정 -->
									<input type="hidden" name="nick" value="aa">
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