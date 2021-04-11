<!-- 상품판매 상세 페이지입니다(은비님) -->
<%@page import="com.market.db.HeartDAO"%>
<%@page import="com.market.db.HeartBean"%>
<%@page import="com.member.db.MemberBean"%>
<%@page import="com.member.db.MemberDAO"%>
<%@page import="com.market.db.GoodsDAO"%>
<%@page import="com.market.db.GoodsBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script type="text/javascript" src="http://code.jquery.com/jquery-3.5.1.js"></script>
	<script type="text/javascript">
		// 게시글 등록일 표기 변경
		var date = null;
		
		function timeForToday(value) {
	        var today = new Date();
	        var timeValue = new Date(value);
	
	        var betweenTime = Math.floor((today.getTime() - timeValue.getTime()) / 1000 / 60);
	        var betweenTimeDay = Math.floor(betweenTime / 60 / 24);
	        var betweenTimeMonth =  Math.floor(betweenTime / 60 / 24 / 30);
	        
	        if (betweenTimeDay < 30) {
	        	date = betweenTimeDay+'일전';
	        }else if(betweenTimeMonth<12){
	        	date = betweenTimeMonth+'달전';
	        }else{
	        	date = Math.floor(betweenTimeDay / 365)+'년전';
	        }
		}
		
		$(function(){
			var v = $('#date').text();
			timeForToday(v);
			if(date == "0일전"){
				date = "오늘";
			}
			$('#date').text(date);
		});
	
		$(function(){
			$("#share").click(function(){
				$("#urlShare").toggle();
				var obShareUrl = document.getElementById('urlShare');
				obShareUrl.value = window.document.location.href;
				obShareUrl.select();
				// select한 값을 클립보드에 복사
				document.execCommand("copy"); 
				obShareUrl.blur();
				alert("URL복사완료");
			});
		});
		</script>
</head>
<body class="product-page ">
<!-- 헤더 -->
<jsp:include page="../inc/top.jsp"/>
<!-- 헤더 -->


 <%
    GoodsBean gb = (GoodsBean)request.getAttribute("goods");
    GoodsDAO gdao = new GoodsDAO();
    
    //조회 수 증가
	int num = Integer.parseInt(request.getParameter("num"));
    gdao.updateReadCount(num);
    
    //본문 줄바꾸기
    String content = gb.getContent();
    
	if(content != null){
		content = content.replace("\r\n", "<br>");
	}
	
	String email = (String) session.getAttribute("email");
	String nick = (String) session.getAttribute("nick");
	
    String nick1 = gb.getNick();
    
 %>
   <input type="hidden" name="num" id="num" value="<%=gb.getG_num()%>">
   <input type="hidden" name="oldfile" id="oldfile" value="<%=gb.getImgs()%>">
  
    <div class="page-header"></div>
     <div class="section">
        <div class="container">
			<div class="main main-raised main-product">
			  <div class="cate">
			  	<a href="./GoodsList.ag"><i class="material-icons">home</i></a>
			  	<i class="material-icons">keyboard_arrow_right</i>
			  	<%=gb.getCategory() %>
			  </div>
				<div class="row">
					<!-- 이미지 슬라이드 전체 영역-->
					<div class="col-md-6 col-sm-6">
						<!-- 이미지 슬라이드/큰이미지 -->
						<div class="tab-content">
							<div class="tab-pane active" id="product-page1">
								<img class="image1" src="./upload/<%=gb.getImgs().split(",")[0] %>">
							</div>
							
							<div class="tab-pane" id="product-page2">
								<img class="image1" src="./upload/<%=gb.getImgs().split(",")[1] %>">
							</div>
							
							<div class="tab-pane" id="product-page3">
								<img class="image1" src="./upload/<%=gb.getImgs().split(",")[2] %>">
							</div>
							
							<div class="tab-pane" id="product-page4">
								<img class="image1" src="./upload/<%=gb.getImgs().split(",")[3] %>">
							</div>
							
							<div class="tab-pane" id="product-page5">
								<img class="image1" src="./upload/<%=gb.getImgs().split(",")[4] %>">
							</div>
							
							<div class="tab-pane" id="product-page6">
								<img class="image1" src="./upload/<%=gb.getImgs().split(",")[5] %>">
							</div>
						</div>
					</div>
						<!-- 이미지 슬라이드/큰이미지 끝 -->



					<!-- 상품정보 -->
					<div class="col-md-6 col-sm-6">
						<!-- 제목 -->
						<h2 class="title"><%=gb.getG_name() %></h2>

						<!-- 가격 -->
						<h3 class="main-price">
							<fmt:formatNumber value="<%=gb.getPrice() %>" pattern="#,###" />
							원
						</h3>

						<div id="accordion">
							<div class="card card-collapse">
								<!-- 게시글 상태 영역 -->
								<div class="col-md-12 col-sm-12 cons">
									<!-- 찜수 -->
									<div class="cons">
										<i class="material-icons">favorite</i><%=gb.getHeart() %>
										<!-- 30은 임시숫자 -->
									</div>

									<!-- 조회수 -->
									<div class="cons">
										<i class="material-icons">visibility</i><%=gb.getRead_count() %>
									</div>

									<!-- 등록일자 -->
									<div class="cons">
										<i class="material-icons">access_time</i><span id="date"><%=gb.getDate() %></span>
									</div>

									<!-- 공유 -->
									<div class="cons share">
										<i class="material-icons" id="share">share</i>
										<input type="text" style="display: none" id="urlShare" class="alert alert-default cpcp" value="" readonly>
									</div>
								</div>
								<!-- 게시글 상태 영역 끝 -->
								<hr>

								<!-- 상품 정보 영역 -->
								<div id="collapseOne" class="collapse show lab">
									<!-- 상품 상태 -->
									<table>
										<tr>
											<td>
									<div class="dtl">
										<div class="st">· 상품 상태</div>
									</td>
											<td>
										<div class="dtd">
											<%=gb.getCondi() %>
										</div>
									</div>
									</td>
										</tr>
										<tr>
											<td>
									<!-- 거래 지역 Location 연결 -->
									<div class="dtl">
										<div class="st">· 거래 가능 지역</div>
									</td>
											<td>
										<div class="dtd">
										     <%=gb.getLocation().split("[0-9]")[0] %>
										</div>
									</div>
										</td>
										</tr>
										<tr>
											<td>
									<!-- 네고 여부 -->
									<div class="dtl">
										<div class="st">· 네고 가능 여부</div>
											</td>
											<td>
										<div class="dtd">
											<%=gb.getNego() %>
										</div>
									</div>
										</td>
										</tr>
									
									</table>
								</div>
								<!-- 상품 정보 영역 끝-->
								
								<hr>
								
						<!-- 이미지 슬라이드/작은 이미지 (split 배열에 이미지 들어있는 수만큼만 출력되게 제어걸어주세요)-->
						<ul class="nav flexi-nav" data-tabs="tabs" id="flexiselDemo1">
							<%if(!(gb.getImgs().split(",")[0].equals("null"))){ %>
							<!-- 0 -->
							<li class="nav-item">
							  <a href="#product-page1"
								class="nav-link" data-toggle="tab"> 
								<img class="image2" src="./upload/<%=gb.getImgs().split(",")[0] %>">
							  </a>
							</li>
							<%} %>
							<!-- 1 -->
							<%if(!(gb.getImgs().split(",")[1].equals("null"))){ %>
							<li class="nav-item">
							  <a href="#product-page2"
								class="nav-link" data-toggle="tab"> 
								<img class="image2" src="./upload/<%=gb.getImgs().split(",")[1] %>">
							  </a>
							</li>
							<%} %>
							<!-- 2 -->
							<%if(!(gb.getImgs().split(",")[2].equals("null"))){ %>
							<li class="nav-item">
							  <a href="#product-page3"
								class="nav-link" data-toggle="tab"> 
								<img class="image2" src="./upload/<%=gb.getImgs().split(",")[2] %>">
							  </a>
							</li>
							<%} %>
							<!-- 3 -->
							<%if(!(gb.getImgs().split(",")[3].equals("null"))){ %>
							<li class="nav-item">
							  <a href="#product-page4"
								class="nav-link" data-toggle="tab"> 
								<img class="image2" src="./upload/<%=gb.getImgs().split(",")[3] %>">
							  </a>
							</li>
							<%} %>
							<!-- 4 -->
							<%if(!(gb.getImgs().split(",")[4].equals("null"))){ %>
							<li class="nav-item">
							  <a href="#product-page5"
								class="nav-link" data-toggle="tab"> 
								<img class="image2" src="./upload/<%=gb.getImgs().split(",")[4] %>">
							  </a>
							</li>
							<%} %>
							<!-- 5 -->
							<%if(!(gb.getImgs().split(",")[5].equals("null"))){ %>
							<li class="nav-item">
							  <a href="#product-page6"
								class="nav-link" data-toggle="tab"> 
								<img class="image2" src="./upload/<%=gb.getImgs().split(",")[5] %>">
							  </a>
							</li>
							<%} %>

						</ul>
					</div>
						<!-- 이미지 슬라이드/작은 이미지 끝 -->
								
								<!-- 버튼 영역 -->
								<div class="ml-auto mr-auto dbtn">
								
									<% 
									   // heart 관련 객체 생성
									   HeartBean hb = new HeartBean();
									   HeartDAO hdao = new HeartDAO();
									   
									   // 상품번호를 heart테이블에 맞게 저장
									   int h_g_num = gb.getG_num();
									   System.out.println("상품 번호"+h_g_num);
									   
									   // 이메일과 상품번호를 이용하여 찜한 상품 정보를 가져옴
									   // 상품번호가 중복될 일이 없기에 사용가능
									   hb = hdao.getHeart(email,h_g_num);
									   
									   System.out.println("찜한 상품 : "+hb);
									   System.out.println("상품 번호 : "+gb.getG_num());
									   
									%>
									
									<!-- 찜하기 버튼 -->
									<%
									  if(email == null) { %>
										<div class="col-md-6">
											<button class="btn btn-primary btn-lg" onclick="alert('로그인 후 찜 가능합니다!');">
												<i class="material-icons">favorite</i> 찜하기
											</button>
										</div>
										<div class="col-md-6">
											<button class="btn btn-primary btn-lg" onclick="alert('로그인 후 채팅 가능합니다!');">
												<i class="material-icons">forum</i> 채팅하기
											</button>
										</div>
									<%}else if (nick.equals(nick1)){ %>
										<div class="col-md-6">
											<button class="btn btn-primary btn-lg" onclick="location.href='./GoodsModify.ag?num=<%=gb.getG_num()%>'">
												<i class="material-icons">create</i> 수정
											</button>
										</div>
										<div class="col-md-6">
											<button class="btn btn-primary btn-lg" onclick="location.href='./GoodsDelete.ag?num=<%=gb.getG_num()%>'">
												<i class="material-icons">clear</i> 삭제
											</button>
										</div>
									<%} else if (!nick.equals(nick1) && hb == null){ %>
										<div class="col-md-6">
											<button class="btn btn-primary btn-lg" onclick="location.href='./heartAdd.he?num=<%=gb.getG_num()%>'">
												<i class="material-icons">favorite</i> 찜하기
											</button>
										</div>
										<div class="col-md-6">
											<button class="btn btn-primary btn-lg" onclick="window.open('./chat?toID=<%=gb.getNick() %>','_blank', 'width=375px, height=667px,toolbars=no,scrollbars=no');return false;">
												<i class="material-icons">forum</i> 채팅하기
											</button>
										</div>
									<% } else if(email != null && hb != null && email.equals(hb.getH_email()) && h_g_num == hb.getH_g_num()){ %>
									
										<!-- 찜하기 취소 버튼 -->
										<div class="col-md-5">
											<button id="heartDeleteBtn" class="btn btn-primary btn-lg" onclick="location.href='./heartDelete.he?num=<%=hb.getH_g_num()%>&h_num=<%=hb.getH_num()%>'">
												<i class="material-icons">favorite</i> 찜취소
											</button>
										</div>
										<div class="col-md-6">
											<button class="btn btn-primary btn-lg" onclick="window.open('./chat?toID=<%=gb.getNick() %>','_blank', 'width=375px, height=667px,toolbars=no,scrollbars=no');return false;">
												<i class="material-icons">forum</i> 채팅하기
											</button>
										</div>
									<% } %>
									
								</div>
								<!-- 버튼 영역 끝-->
								
							</div>
						</div>
					</div>
				</div>
				<hr>
				<!-- 상세 설명 영역 -->			
				<div class="main-content">
					<%=content %>
				</div>
				
				<div class="review-page">
				
				<div>
                   <button onclick="location.href='./reviewList.re?s_nick=<%=gb.getNick()%>'">
                      	판매자 리뷰
                   </button>
                </div>
                
				<!-- 리뷰 페이지 대기중 -->
				<%-- <jsp:include page="../review/reviewList.jsp"/> --%>
				<!-- 리뷰 페이지 대기중 -->
				</div>
				
				<!-- 상세 설명 영역 -->			
			</div>
         </div>

<!-- 푸터 -->
<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터 -->
</body>
</html>