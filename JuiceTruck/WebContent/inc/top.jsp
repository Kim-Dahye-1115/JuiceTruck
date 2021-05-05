<!-- 헤더입니다. -->
<!DOCTYPE html>
<%@page import="com.member.db.MemberDAO"%>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <!-- Favicons -->
    <link rel="apple-touch-icon" href="../assets/img/apple-icon.png">
    <link rel="icon" href="../assets/img/favicon.png">
	<title>주변에서 스피디하게!주스트럭</title>
    <!--     Fonts and icons     -->
    <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />
    <link rel="stylesheet" href="./assets/css/material-kit.css?v=2.0.3">
    <!-- Documentation extras -->
    <!-- CSS Just for demo purpose, don't include it in your project -->
    <link href="./assets/assets-for-demo/demo.css" rel="stylesheet" />
    <link href="./assets/assets-for-demo/vertical-nav.css" rel="stylesheet" />
</head>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<header>
	<%
	// 한글처리
	request.setCharacterEncoding("UTF-8");
	
    String email = (String) session.getAttribute("email");
    String nick = (String) session.getAttribute("nick");
    
    MemberDAO mdao = new MemberDAO();
    String user_img = "./upload/"+mdao.getProfile(nick);
    
	%>

 <nav class="navbar fixed-top  navbar-expand-lg topmar no-shadow" id="sectionsNav">
	<div class="container">
       <!-- 접속자 표시 자리 -->
		<div class="collapse navbar-collapse">
        <%
    	  if(email == null){%>
    	<div class="navbar-translate">
                <a class="navbar-brand" href="./MemberLogin.me">
                	<img src="./person.png" class="rounded-circle img-fluid image4">
					 게스트 님 어서오세요!
                </a>
            </div>
    	<%}else{%>
            <div class="navbar-translate">
                <a class="navbar-brand" href="./Update.me">
                	<img src="<%=user_img %> " class="rounded-circle img-fluid image4">
					 <%=nick %> 님 환영합니다!
                </a>
            </div>
        <%} %>    
        <!-- 접속자 표시 자리 -->
            
			<%
    		  if(email == null){
    		%>
    			<ul class="navbar-nav ml-auto" style="visibility: hidden;"></ul>
    		<!-- 로그인 안된 상태 -->
				  <a class="log" href="./MemberLogin.me">로그인</a>|
				  <a class="log" href="./JoinTerms.me">회원가입</a>
			<!-- 로그인 안된 상태 -->

    		<%
			  } else{
			%>
			<!-- 내 정보 토글 -->
				<ul class="navbar-nav ml-auto">
					<li class="dropdown nav-item">
						<a href="#" class="dropdown-toggle nav-link" data-toggle="dropdown">
						<i class="material-icons">local_drink</i>내 메뉴</a>
						
						<div class="dropdown-menu dropdown-with-icons">
							<a href="./Update.me" class="dropdown-item">
								<i class="material-icons">account_circle</i>내정보</a>
								
							<a href="./MyGoods.mg" class="dropdown-item">
								<i class="material-icons">storefront</i>내트럭</a>
								
							<a href="./GoodsAdd.ag" class="dropdown-item">
								<i class="material-icons">attach_money</i>판매하기</a>
								
							<a href="./reviewList.re" class="dropdown-item">
								<i class="material-icons">star</i>내리뷰</a>
								
							<a href="./heartList.he" class="dropdown-item">
								<i class="material-icons">favorite_border</i>찜한상품</a>
								
							<a href="./qnaList.qa" class="dropdown-item">
	                           	 <i class="material-icons">live_help</i>고객센터</a>
	                           	 
	                        <a href="./noticeList.no" class="dropdown-item">
	                           	 <i class="material-icons">info</i>공지사항</a>
						</div>
					</li>
				</ul>
			<!-- 내 정보 토글 -->
			
			<!-- 로그인 된 상태 -->
				<a class="log" href="./MemberLogout.me">로그아웃</a>
			<!-- 로그인 된 상태 -->
			<%
    		  }
    		%>  
		</div>
		<!-- 사이트 로고 -->
        <div class="jtl">
          <div class="col-md-1">
           <a href="./GoodsList.ag">
        	<img src="./jtLogo.png">
           </a>
          </div>
		<!-- 사이트 로고 -->
		<!-- 검색창 -->
			<div class="col-md-5 ml-auto mr-auto">
				<form class="text-center" action="./search.se" method="get">
					<input type="text" class="form-control" name="search" placeholder="상품명,카테고리,상점명을 입력하세요">
					<button type="submit" class="btn btn-primary btn-link search">
						<i class="material-icons searchicon">search</i></button>
				</form>
			</div>
		<!-- 검색창 -->
		 <!-- 채팅로고 -->
		 <div class="col-md-2">
		 	<a href="./box" onclick="window.open(this.href,'_blank', 'width=375px, height=667px,toolbars=no,scrollbars=no');return false;">
		 	  <img src="./jst.png">
		 	</a>
         </div>
		 <!-- 채팅로고 -->
        </div>    
			
		<!-- 메뉴 토글 -->
		<div class="btn-group col-md-2 mr-auto">
			<button type="button" class="btn btn-primary btn-link search"
				data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<i class="material-icons line">menu</i></button>
			<div class="dropdown-menu">
				<a class="dropdown-item">상품 카테고리</a>
				<div class="dropdown-divider"></div>
				<a class="dropdown-item" href="./GoodsList.ag?item=여성의류">여성의류</a> 
				<a class="dropdown-item" href="./GoodsList.ag?item=남성의류">남성의류</a> 
				<a class="dropdown-item" href="./GoodsList.ag?item=패션잡화">패션잡화</a>
				<a class="dropdown-item" href="./GoodsList.ag?item=디지털/가전">디지털/가전</a> 
				<a class="dropdown-item" href="./GoodsList.ag?item=음반/도서/티켓">음반/도서/티켓</a> 
				<a class="dropdown-item" href="./GoodsList.ag?item=생활/취미">생활/취미</a> 
				<a class="dropdown-item" href="./GoodsList.ag?item=동물 용품">동물 용품</a> 
				<a class="dropdown-item" href="./GoodsList.ag?item=뷰티/미용">뷰티/미용</a> 
				<a class="dropdown-item" href="./GoodsList.ag?item=아동 용품">아동용품</a> 
				<a class="dropdown-item" href="./GoodsList.ag?item=나눔">나눔</a>
			</div>
		</div>
		<!-- 메뉴 토글 -->
       </div>
</nav>

 

    <!--   Core JS Files   -->
    <script src="./assets/js/core/jquery.min.js"></script>
    <script src="./assets/js/core/popper.min.js"></script>
    <script src="./assets/js/bootstrap-material-design.js"></script>
    <!--  Plugin for Date Time Picker and Full Calendar Plugin  -->
    <script src="./assets/js/plugins/moment.min.js"></script>
    <!--	Plugin for the Datepicker, full documentation here: https://github.com/Eonasdan/bootstrap-datetimepicker -->
    <script src="./assets/js/plugins/bootstrap-datetimepicker.min.js"></script>
    <!--	Plugin for the Sliders, full documentation here: http://refreshless.com/nouislider/ -->
    <script src="./assets/js/plugins/nouislider.min.js"></script>
    <!--	Plugin for Select, full documentation here: http://silviomoreto.github.io/bootstrap-select -->
    <script src="./assets/js/plugins/bootstrap-selectpicker.js"></script>
    <!--	Plugin for Tags, full documentation here: http://xoxco.com/projects/code/tagsinput/  -->
    <script src="./assets/js/plugins/bootstrap-tagsinput.js"></script>
    <!--	Plugin for Fileupload, full documentation here: http://www.jasny.net/bootstrap/javascript/#fileinput -->
    <script src="./assets/js/plugins/jasny-bootstrap.min.js"></script>
    <!--	Plugin for Small Gallery in Product Page -->
    <script src="./assets/js/plugins/jquery.flexisel.js"></script>
    <!-- Plugins for presentation and navigation  -->
    <script src="./assets/assets-for-demo/js/modernizr.js"></script>
    <script src="./assets/assets-for-demo/js/vertical-nav.js"></script>
    <!-- Material Kit Core initialisations of plugins and Bootstrap Material Design Library -->
    <script src="./assets/js/material-kit.js?v=2.0.3"></script>
    <!-- Fixed Sidebar Nav - js With initialisations For Demo Purpose, Don't Include it in your project -->
    <script src="./assets/assets-for-demo/js/material-kit-demo.js"></script>
    <script>
        $(document).ready(function() {

            var slider2 = document.getElementById('sliderRefine');

            noUiSlider.create(slider2, {
                start: [101, 790],
                connect: true,
                range: {
                    'min': [30],
                    'max': [900]
                }
            });

            var limitFieldMin = document.getElementById('price-left');
            var limitFieldMax = document.getElementById('price-right');

            slider2.noUiSlider.on('update', function(values, handle) {
                if (handle) {
                    limitFieldMax.innerHTML = $('#price-right').data('currency') + Math.round(values[handle]);
                } else {
                    limitFieldMin.innerHTML = $('#price-left').data('currency') + Math.round(values[handle]);
                }
            });
        });
    </script>    
   
</header>